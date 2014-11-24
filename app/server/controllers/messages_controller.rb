class MessagesController < ApplicationController

  include Nali::Controller

  before do check_auth end
  before_only :history do check_dialog end

  selector :history do
    @dialog.messages.order( created_at: :desc ).limit( 20 ).offset params[ :offset ]
  end

  private

  def check_dialog
    stop unless @dialog = Dialog.find_by_id( params[ :dialog_id ] ) and @user.dialogs.include?( @dialog )
  end

end
