module Nali::Clients

  def client_disconnected( client )
    client[ :user ] and client[ :user ].offline
  end

end
