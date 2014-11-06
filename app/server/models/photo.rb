class Photo < ActiveRecord::Base

  include Nali::Model

  has_many   :messagephotos, inverse_of: :photo, dependent: :destroy
  belongs_to :user,          inverse_of: :photos

  after_initialize do
    self.secret ||= generate_secret
  end

  after_destroy do
    remove_photo :small, :medium , :large
  end

  def path( size )
    Nali::Application.settings.root + '/public/images/photos/' + size.to_s + '/' + self.secret + '.jpg'
  end

  def remove_photo( *sizes )
    sizes.each { |size| if File.exists? p = path( size ) then File.delete p end }
  end

  def generate_secret
    begin
      secret = SecureRandom.hex 16
    end while Photo.exists?( secret: secret )
    secret
  end

  def access_level( client )
    if user = client[ :user ]
      return :owner if self.user_id == user.id
      opponents = []
      self.messagephotos.each do |messagephoto|
        messagephoto.message.dialog.contacts.each { |contact| opponents << contact.contact_id }
      end
      return :contact if opponents.include?( user.id )
    end
    :unknown
  end

end
