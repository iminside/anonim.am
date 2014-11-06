class Photo < ActiveRecord::Base

  include Nali::Model

  has_many   :messagephotos, inverse_of: :photo, dependent: :destroy
  has_many   :messages,      through: :messagephotos
  has_many   :dialogs,       through: :messages
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
      return :owner   if self.user_id == user.id
      self.dialogs.each{ |dialog| return :contact if dialog.users.include?( user ) }
    end
    :unknown
  end

end
