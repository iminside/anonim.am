class Message < ActiveRecord::Base

  include Nali::Model

  belongs_to :user
  belongs_to :dialog,        inverse_of: :messages
  has_many   :messagephotos, inverse_of: :message, dependent: :destroy
  has_many   :dialog_users,  through: :dialog, source: :users

  validates :text,      length: { in: 1..1000 }
  validates :user_id,   numericality: { only_integer: true }
  validates :dialog_id, numericality: { only_integer: true }

  after_save do
    unless @skipped_after_save then sync_opponent else @skipped_after_save = false end
  end

  def skip_after_save
    @skipped_after_save = true
    self
  end

  def sync_opponent
    self.dialog.contacts.each do |contact|
      if contact.user != self.user
        contact.user.my_clients do |client|
          client.sync self
          client.notice :newmsg
        end
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
      return :autor   if self.dialog_users.include?( user ) and self.user_id == user.id
      return :contact if self.dialog_users.include?( user )
    end
    :unknown
  end

end
