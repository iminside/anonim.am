require 'rubygems'
require 'bundler/setup'
Bundler.require

module Nali
  
  class Application
    
    configure do |config|

      config.client.append_path 'public/client/images'
      config.client.append_path 'public/client/fonts'

    end

  end
  
end
