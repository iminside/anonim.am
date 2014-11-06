class Dialog < ActiveRecord::Base

  include Nali::Model

  has_many :messages, inverse_of: :dialog, dependent: :destroy
  has_many :contacts, inverse_of: :dialog, dependent: :destroy

  def access_level( client )
    if user = client[ :user ]
      self.contacts.each { |contact| return :contact if contact.dialog_id == self.id }
    end
    :unknown
  end

end
