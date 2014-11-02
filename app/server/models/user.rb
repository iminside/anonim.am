# encoding: utf-8
class User < ActiveRecord::Base

  include Nali::Model

  has_many  :contacts
  has_many  :photos,  dependent: :destroy

  validates :name,   length: { in: 3..30 }
  validates :gender, inclusion: { in: %w(man woman) }
  validates :color,  inclusion: { in: %w(red orange yellow green azure blue violet) }
  validates :token,  length: { is: 32 }, uniqueness: true
  validates :search, inclusion: { in: 0..3 }
  validates :who,    inclusion: { in: %w(man woman all) }
  validates :how,    inclusion: { in: 1..3 }

  after_initialize do
    self.token ||= generate_token
    self.name  ||= self.gender == 'man' ? 'Аноним' : 'Анонимка'
  end

  after_save do
    client and client[ :user ].reload
  end

  before_destroy do
    self.contacts.each { |contact| contact.dialog.destroy }
    remove_avatar
  end

  def avatar_path
    Nali::Application.settings.root + '/public/images/avatars/' + self.avatar + '.jpg'
  end

  def remove_avatar( generate_new = false )
    File.delete avatar_path if self.avatar? and File.exists? avatar_path
    if generate_new then generate_avatar_name else self.avatar = nil end
    save
  end

  def generate_token
    begin
      token = SecureRandom.hex 16
    end while User.exists?( token: token )
    token
  end

  def generate_avatar_name
    begin
      self.avatar = SecureRandom.hex 16
    end while File.exists?( avatar_path )
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
    if user = client[ :user ]
      if client[ :user ] == self
        return :owner
      else
        client[ :user ].contacts.each { |contact| return :contact if contact.contact.user == self }
      end
    end
    :unknown
  end

end
