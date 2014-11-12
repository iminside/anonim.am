class PhotosController < ApplicationController

  include Nali::Controller

  before do check_auth  end
  before_only :upload_photo, :upload_avatar do upload_image end

  def upload_photo
    photo = @user.photos.create secret: "v#{ @uploaded[ 'version' ] }/#{ @uploaded[ 'public_id' ] }"
    photo.sync client
    trigger_success
  end

  def upload_avatar
    @user.replace_avatar "v#{ @uploaded[ 'version' ] }/#{ @uploaded[ 'public_id' ] }"
    @user.sync
    trigger_success
  end

  private

    def upload_image
      stop unless @uploaded = Cloudinary::Uploader.upload( params[ :image ] )
    end

end
