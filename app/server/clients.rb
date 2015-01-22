module Nali::Clients

  def client_connected( client )
    trigger_online
  end

  def client_disconnected( client )
    client[ :user ] and client[ :user ].offline
    trigger_online
  end

  private

    def trigger_online
      clients.each { |client| client.app_run :setOnline, clients.collect( &:browser_id ).uniq.length }
    end

end
