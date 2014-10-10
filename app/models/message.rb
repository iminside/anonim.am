class Message < ActiveRecord::Base

  include Nali::Model
  
  belongs_to :dialog
  belongs_to :user
  
  validates :text,      presence: true
  validates :user_id,   presence: true
  validates :dialog_id, presence: true
  
  after_save do
    self.dialog.contacts.each do |contact|
      if contact.user != self.user and !contact.active?
        contact.counter += 1
        contact.save
        contact.sync
      end
    end
  end
  
  after_destroy { sync }
  
  def access_level( client )
    if user = client[ :user ]
      opponents = []
      self.dialog.contacts.each { |contact| opponents << contact.user }
      return :contact if opponents.include?( self.user ) and opponents.include?( user )
    end
    :unknown
  end

end
