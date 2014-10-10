module Nali
  
  module Clients

    def self.client_disconnected( client )
      count = 0
      if user = client[ :user ]
        clients.each { |client| count += 1 if client[ :user ] and client[ :user ].id == user.id }
        if count == 0
          user.contacts.where( active: true ).each { |contact| contact.update_attribute( :active, false ) }
          user.update_attribute :online, false
          user.sync
        end
      end
    end
    
  end
  
end