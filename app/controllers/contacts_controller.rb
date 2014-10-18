class ContactsController < ApplicationController
  
  include Nali::Controller
  
  before do check_auth end
  
end  