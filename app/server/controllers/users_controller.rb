# encoding: utf-8
class UsersController < ApplicationController

  include Nali::Controller

  before_except :build, :auth do check_auth end

  def build
    user = User.new gender: params[ :gender ], color: params[ :color ]
    if user.save
      trigger_success user.token
    else
      trigger_failure
    end
  end

  def auth
    if @user = User.find_by_token( params[ :token ] )
      @user.update online: true
      client[ :user ] = @user
      @user.sync client
      trigger_success @user.id
      search
    else
      trigger_failure
    end
  end

  def logout
    client.reset
    @user.logout
  end

  def delete_avatar
    @user.remove_avatar
    @user.sync
  end

  def to_email
    email = params[ :email ]
    Mail.deliver do
      to      email
      from    'Сервис анонимного общения <robot@isite.im>'
      subject 'Кнопка автологина ( iSite.im )'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<div style=\"margin:2rem;border-radius:5px;padding:2rem;font-size:1.5rem;background:whitesmoke\">
                <b style=\"font-size:2rem\">Здравствуйте, #{ @user.name }!</b>
                <div style=\"display: table; margin-top: 1rem\">
                  <p style=\"margin:0;display: table-cell; padding-right:1rem; font-size: 1.1rem; vertical-align: middle;\">
                    Чтобы войти в свой аккаунт на сервисе анонимного общения - iSite.im, нажмите кнопку
                  </p>
                  <a href=\"http://isite.im/user/auth/#{ @user.token }\" style=\"display: table-cell;background:#52bad5;padding:.5rem 3rem;border-radius:.3rem;text-decoration:none;color:white;float:right;font-weight:bold;font-size:2rem\" target=\"_blank\">Войти</a>
                </div>
              </div>"
      end
    end
    trigger_success
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
            contact.user.client.notice :fresh, contact
            contact.user.update search: ( contact.user.search - 1 )
            contact.user.sync
            contact.sync
          end
          break
        end
      end
    end
  end

end
