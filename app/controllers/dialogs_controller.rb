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
  
  def send_photos
    if dialog = Dialog.find_by_id( params[ :dialog_id ] )
      ( message = dialog.messages.new( user_id: @user.id ) ).save validate: false
      params[ :photos_id ].each { |id| message.messagephotos.create( photo_id: id ) }
      message.sync
    end
  end

end
