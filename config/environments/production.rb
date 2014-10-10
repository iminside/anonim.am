require 'uglifier'
require 'yui/compressor'

Nali::Application.configure :production do |config|
  
  config.assets_digest = true
  
  config.assets.js_compressor  = Uglifier.new( mangle: true )

  config.assets.css_compressor = YUI::CssCompressor.new
  
end