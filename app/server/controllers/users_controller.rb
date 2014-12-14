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
    client.all_tabs do |tab|
      tab.call_method :logout, @user
      tab.reset
    end
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
        from    'Сервис анонимного общения <robot@isite.im>'
        subject 'Кнопка автологина ( iSite.im )'
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
      ( ignor = [] ) << @user.id
      @user.contacts.each { |contact| ignor << contact.contact_id }
      clients.each do |client|
        anon = client[ :user ]
        if anon and anon.search > 0 and ignor.exclude?( anon.id ) and
          ( anon.who == 'all' or anon.who == @user.gender ) and
          ( @user.who == 'all' or @user.who == anon.gender )
          dialog   = Dialog.create
          contacts = []
          contacts << @user.contacts.create( dialog: dialog, contact: anon )
          contacts << anon.contacts.create( dialog: dialog, contact: @user )
          contacts.each do |contact|
            contact.user.my_clients{ |client| client.call_method :fresh, contact }
            contact.user.update search: ( contact.user.search - 1 )
            contact.user.sync
          end
          break
        end
      end
    end
  end

end
