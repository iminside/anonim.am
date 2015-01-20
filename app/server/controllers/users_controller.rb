# encoding: utf-8
class UsersController < ApplicationController

  include Nali::Controller

  before_except :create, :auth do check_auth end

  def create
    user = User.new gender: params[ :gender ], color: params[ :color ]
    if user.save
      trigger_success user.token
    else
      trigger_failure
    end
  end

  def auth
    if !client[ :user ] and @user = User.find_by_token( params[ :token ] )
      @user.update online: true
      client[ :user ] = @user
      @user.sync client
      trigger_success @user.id
      client.other_tabs { |tab| tab.app_run( :auth, @user.token ) unless tab[ :user ] }
      search
    else
      trigger_failure
    end
  end

  def logout
    client.all_tabs { |tab| tab.call_method( :logout, @user ).reset }
    @user.offline
  end

  def delete_avatar
    @user.remove_avatar
    @user.sync
  end

  def to_email
    if ( email = params[ :email ] ) =~ /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
      require 'erb'
      email_body = ERB.new( File.read( 'app/server/templates/email.html.erb' ) ).result binding
      Mail.deliver do
        to      email
        from    'Сервис анонимного общения <robot@anonim.am>'
        subject 'Кнопка автологина ( anonim.am )'
        html_part do
          content_type 'text/html; charset=UTF-8'
          body email_body
        end
      end
      trigger_success
    end
  end

  def search
    if @user.search > 0

      found = clients.map{ |client| client[ :user ] }.compact.select do |anonim|
        anonim != @user                                       and
        anonim.search > 0                                     and
        @user.contacts_users.exclude?( anonim )               and
        ( anonim.who == 'all' or anonim.who == @user.gender ) and
        ( @user.who == 'all' or @user.who == anonim.gender )
      end

      found.first( @user.search ).each do |anonim|
        dialog = Dialog.create
        [
          @user.contacts.create( dialog: dialog, contact: anonim ),
          anonim.contacts.create( dialog: dialog, contact: @user )
        ].each do |contact|
          contact.user.my_clients{ |client| client.call_method :fresh, contact }
          contact.user.update search: ( contact.user.search - 1 )
          contact.user.sync
        end
      end

    end
  end

end
