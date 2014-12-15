class DialogsController < ApplicationController

  include Nali::Controller

  before do check_auth end

  def writes
    @user.contacts.where( active: true ).each do |contact|
      contact.dialog.contacts.each do |contact|
        if contact.user_id != @user.id and contact.active?
          contact.user.my_clients { |client| client.call_method :writes, contact.dialog }
        end
      end
    end
  end

end
