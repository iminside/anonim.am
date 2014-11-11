class PhotosController < ApplicationController

  include Nali::Controller

  before do check_auth  end
  before_only :upload_photo, :upload_avatar do check_image end

  def upload_photo
    photo = @user.photos.create
    write_image large_path = photo.path( :large )
    medium_size = resize_size large_path, 300
    small_size  = resize_size large_path, 150
    Image.resize( large_path, photo.path( :medium ), medium_size, medium_size )
    Image.resize( large_path, photo.path( :small ),  small_size,  small_size )
    photo.save
    photo.sync client
    trigger_success
  end

  def upload_avatar
    @user.remove_avatar true
    write_image @user.avatar_path
    @user.sync
    trigger_success
  end

  private

  def check_image
    unless params[ :image ] and @image = params[ :image ][ 'data:image/jpeg;base64,'.length .. -1 ]
      trigger_failure
      stop
    end
  end

  def write_image( path )
    File.open( path, 'wb') { |file| file.write( Base64.decode64( @image ) ) }
  end

  def resize_size( path, min_size )
    width, height = FastImage.size( path ).map{ |size| size.to_f }
    ratio = width / height
    case
      when ratio < 1 then size = min_size * height / width
      when ratio > 1 then size = min_size * width / height
      else                size = min_size
    end
    size.ceil
  end

end
