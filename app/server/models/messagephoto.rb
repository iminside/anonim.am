class Messagephoto < ActiveRecord::Base

  include Nali::Model

  belongs_to :message, inverse_of: :messagephotos
  belongs_to :photo, inverse_of: :messagephotos

  validates :message_id, numericality: { only_integer: true }
  validates :photo_id,   numericality: { only_integer: true }

  def access_level( client )
    if user = client[ :user ]
      opponents = []
      self.message.dialog.contacts.each { |contact| opponents << contact.contact_id }
      return :contact if opponents.include?( user.id )
    end
    :unknown
  end

end
