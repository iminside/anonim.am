class Message < ActiveRecord::Base

  include Nali::Model

  belongs_to :user
  belongs_to :dialog,        inverse_of: :messages
  has_many   :messagephotos, inverse_of: :message, dependent: :destroy

  validates :text,      length: { in: 1..1000 }
  validates :user_id,   numericality: { only_integer: true }
  validates :dialog_id, numericality: { only_integer: true }

  after_save do
    self.dialog.contacts.each do |contact|
      if contact.user != self.user
        if client = contact.user.client then client.notice :newmsg end
        if !contact.active?
          contact.counter += 1
          contact.save
          contact.sync
        end
      end
    end
  end

  def access_level( client )
    return :contact if user = client[ :user ] and self.dialog.users.include?( user )
    :unknown
  end

end
