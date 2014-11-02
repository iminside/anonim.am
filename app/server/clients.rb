module Nali::Clients

  def client_disconnected( client )
    if user = client[ :user ] then user.logout end
  end

end
