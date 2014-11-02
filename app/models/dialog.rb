class Dialog < ActiveRecord::Base
  
  include Nali::Model

  has_many :messages, dependent: :destroy
  has_many :contacts, dependent: :destroy
  
  def access_level( client )
    if user = client[ :user ]
      self.contacts.each { |contact| return :contact if contact.dialog == self }
    end
    :unknown
  end
  
end
