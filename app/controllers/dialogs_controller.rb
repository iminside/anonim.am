class DialogsController < ApplicationController 
  
  include Nali::Controller
  
  before do check_auth end
  
  def writes
    @user.contacts.where( active: true ).each do |contact|
      if contact.contact.active? and opp_client = contact.contact.user.client 
        opp_client.notice :writes, contact.dialog
      end
    end
  end
  
end