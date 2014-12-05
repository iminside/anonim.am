class Photo < ActiveRecord::Base

  include Nali::Model

  has_many   :messagephotos, inverse_of: :photo, dependent: :destroy
  has_many   :dialogs,       through: :messagephotos
  has_many   :dialogs_users, through: :dialogs, source: :users
  belongs_to :user,          inverse_of: :photos

  after_destroy do
    remove_photo
  end

  def remove_photo
    Cloudinary::Api.delete_resources [ self.secret.split( '/' )[1] ]
  end

  def access_level( client )
    if user = client[ :user ]
      return :owner if self.user_id == user.id
      return :contact if self.dialogs_users.include?( user )
    end
    :unknown
  end

end
