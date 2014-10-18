module Nali
  
  module Clients

    def client_disconnected( client )
      if user = client[ :user ]
        user.logout 
      end
    end
    
  end
  
end