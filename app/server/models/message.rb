class Message < ActiveRecord::Base

  include Nali::Model

  belongs_to :dialog
  belongs_to :user
  has_many   :messagephotos, dependent: :destroy

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
    if user = client[ :user ]
      opponents = []
      self.dialog.contacts.each { |contact| opponents << contact.user.id }
      return :contact if opponents.include?( user.id )
    end
    :unknown
  end

end
