class Contact < ActiveRecord::Base

  include Nali::Model
  
  belongs_to :contact
  belongs_to :user
  belongs_to :dialog
  
  after_destroy do
    self.sync
    self.user.client and self.user.client[ :user ].contacts.reload
  end
  
  def access_level( client )
    if user = client[ :user ]
      return :owner   if self.user == user
      return :contact if self.contact and self.contact.user == user
    end
    :unknown
  end
  
end
