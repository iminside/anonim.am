class Dialog < ActiveRecord::Base

  include Nali::Model

  has_many :messages, inverse_of: :dialog, dependent: :destroy
  has_many :contacts, inverse_of: :dialog, dependent: :destroy
  has_many :users,    through: :contacts

  def access_level( client )
    return :contact if user = client[ :user ] and self.users.include?( user )
    :unknown
  end

end
