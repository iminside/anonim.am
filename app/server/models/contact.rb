class Contact < ActiveRecord::Base

  include Nali::Model

  belongs_to :user,    inverse_of: :contacts
  belongs_to :contact, class_name: 'User'
  belongs_to :dialog,  inverse_of: :contacts

  validates :active,     inclusion: { in: [ true, false ] }
  validates :counter,    numericality: { only_integer: true }

  after_destroy do
    self.user.client and self.user.client[ :user ].contacts.reload
  end

  def access_level( client )
    return :owner if user = client[ :user ] and self.user_id == user.id
    :unknown
  end

end
