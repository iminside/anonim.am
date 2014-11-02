class Messagephoto < ActiveRecord::Base

  include Nali::Model

  belongs_to :message
  belongs_to :photo

  validates :message_id, numericality: { only_integer: true }
  validates :photo_id,   numericality: { only_integer: true }

  def access_level( client )
    if user = client[ :user ]
      opponents = []
      self.message.dialog.contacts.each { |contact| opponents << contact.user.id }
      return :contact if opponents.include?( user.id )
    end
    :unknown
  end

end
