# encoding: utf-8
class UsersController
  
  include Nali::Controller
  
  def build
    user = User.new gender: params[ :gender ], color: params[ :color ] 
    if user.valid?
      user.save
      trigger_success user.token
    else
      trigger_failure
    end
  end
  
  def auth
    if user = User.find_by_token( params[ :token ] )
      user.update online: true
      client[ :user ] = user
      user.sync client
      trigger_success user.id
      search 
    else
      trigger_failure
    end
  end
  
  def to_email
    p email = params[ :email ]
    mail = Mail.deliver do
      to      email
      from    'Test <user@example.com>'
      subject 'Ссылка автологина'

      text_part do
        body 'This is plain text'
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<h1>This is HTML</h1>'
      end
      
    end
    p mail
  end
  
  def search
    if ( user = client[ :user ] ).search > 0
      ( ignor = [] ) << user.id
      user.contacts.each { |contact| ignor << contact.contact.user.id }
      clients.each do |client|
        anon = client[ :user ]
        if anon and anon.search > 0 and ignor.exclude?( anon.id ) and 
          ( anon.who == 'all' or anon.who == user.gender ) and 
          ( user.who == 'all' or user.who == anon.gender )
          
          dialog   = Dialog.create
          contacts = []
          contacts << user.contacts.create( dialog: dialog )
          contacts << anon.contacts.create( dialog: dialog )
          contacts[0].contact = contacts[1] 
          contacts[1].contact = contacts[0]
          contacts.each { |contact| contact.save }
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
