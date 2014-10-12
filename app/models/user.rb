# encoding: utf-8
class User < ActiveRecord::Base

  include Nali::Model
  
  has_many   :contacts
  
  validates :name,   presence: true, length: { in: 3..30 }
  validates :gender, presence: true, inclusion: { in: %w(man woman) }
  validates :color,  presence: true, inclusion: { in: %w(red orange yellow green azure blue violet) }
  validates :token,  length: { is: 32 }, uniqueness: true
  validates :search, inclusion: { in: 0..3 }
  validates :who,    inclusion: { in: %w(man woman all) }
  validates :how,    inclusion: { in: 1..3 }
  
  after_initialize do
    self.token ||= SecureRandom.hex 16 
    self.name  ||= self.gender == 'man' ? 'Аноним' : 'Анонимка'
  end
  
  after_save do
    client and client[ :user ].reload
  end
  
  before_destroy do
    self.contacts.each { |contact| contact.dialog.destroy }
  end
  
  def client
    clients.each { |client| return client if client[ :user ] and client[ :user ].id == self.id }  
    nil
  end
  
  def logout
    count = 0
    clients.each { |client| count += 1 if client[ :user ] and client[ :user ].id == self.id }
    if count == 0
      self.contacts.where( active: true ).each { |contact| contact.update( active: false ) }
      self.update online: false
      self.sync
    end
  end
  
  def access_level( client )
    if client[ :user ] == self
      :owner
    else 
      client[ :user ].contacts.each { |contact| return :contact if contact.contact.user == self }
      :unknown
    end
  end

end