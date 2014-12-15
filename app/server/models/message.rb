class Message < ActiveRecord::Base

  include Nali::Model

  belongs_to :user
  belongs_to :dialog,        inverse_of: :messages
  has_many   :messagephotos, inverse_of: :message, dependent: :destroy
  has_many   :dialog_users,  through: :dialog, source: :users

  validates :text,      length: { in: 1..1000 }
  validates :user_id,   numericality: { only_integer: true }
  validates :dialog_id, numericality: { only_integer: true }

  def access_level( client )
    return :contact if user = client[ :user ] and self.dialog_users.include?( user )
    :unknown
  end

end
