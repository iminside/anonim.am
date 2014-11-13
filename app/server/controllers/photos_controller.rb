class PhotosController < ApplicationController

  include Nali::Controller

  before do check_auth  end
  before_only :upload_photo, :upload_avatar do upload_image end

  def upload_photo
    photo = @user.photos.create secret: image_secret
    photo.sync client
    trigger_success
  end

  def upload_avatar
    @user.replace_avatar image_secret
    @user.sync
    trigger_success
  end

  private

    def upload_image
      stop unless @uploaded = Cloudinary::Uploader.upload( params[ :image ] )
    end

    def image_secret
      "v#{ @uploaded[ 'version' ] }/#{ @uploaded[ 'public_id' ] }"
    end

end
