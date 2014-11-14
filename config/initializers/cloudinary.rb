Cloudinary.config do |config|

  config.cloud_name = ENV[ 'CLOUDINARY_CLOUD' ]
  config.api_key    = ENV[ 'CLOUDINARY_KEY' ]
  config.api_secret = ENV[ 'CLOUDINARY_SECRET' ]

end
