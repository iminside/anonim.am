class MessagesController < ApplicationController

  include Nali::Controller

  before do check_auth end
  before_only :history, :create do check_dialog end

  selector :history do
    @dialog.messages.order( created_at: :desc ).limit( 20 ).offset params[ :offset ]
  end

  def create
    ( @message = @dialog.messages.new( user: @user ) ).save validate: false
    attach_photos
    if not @message.update( text: params[ :text ] ) and @message.messagephotos.count == 0
      @message.destroy
    else
      sync_new_message
    end
  end

  private

    def attach_photos
      if params[ :photos_id ].is_a?( Array )
        params[ :photos_id ].each do |id|
          if photo = Photo.find_by_id( id ) and photo.user_id == @user.id
            @message.messagephotos.create photo: photo
          end
        end
      end
    end

    def sync_new_message
      @dialog.contacts.each do |contact|
        if contact.user != @user
          contact.user.my_clients { |client| client.notice :newmsg }
          if !contact.active?
            contact.counter += 1
            contact.save
            contact.sync
          end
        end
        contact.user.my_clients { |client| client.sync @message }
      end
    end

    def check_dialog
      stop unless @dialog = Dialog.find_by_id( params[ :dialog_id ] ) and @user.dialogs.include?( @dialog )
    end

end
