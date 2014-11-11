class DialogsController < ApplicationController

  include Nali::Controller

  before do check_auth end

  def writes
    @user.contacts.where( active: true ).each do |contact|
      contact.dialog.contacts.each do |contact|
        if contact.user_id != @user.id and contact.active? and opp_client = contact.user.client
          opp_client.notice :writes, contact.dialog
        end
      end
    end
  end

  def send_photos
    if dialog = Dialog.find_by_id( params[ :dialog_id ] ) and @user.dialogs.include?( dialog )
      ( message = dialog.messages.new( user: @user ) ).skip_after_save.save validate: false
      params[ :photos_id ].each do |id|
        if photo = Photo.find_by_id( id ) and photo.user_id == @user.id
          message.messagephotos.create photo: photo
        end
      end
      if message.messagephotos.count > 0
        message.sync_opponent
        client.sync message
      else message.destroy end
    end
  end

end
