# encoding: utf-8
class User < ActiveRecord::Base

  include Nali::Model

  has_many :contacts,       inverse_of: :user
  has_many :contacts_users, through: :contacts, source: :contact
  has_many :photos,         inverse_of: :user,  dependent: :destroy
  has_many :dialogs,        through: :contacts

  validates :name,   length: { in: 3..30 }
  validates :gender, inclusion: { in: %w(man woman) }
  validates :color,  inclusion: { in: %w(red orange yellow green azure blue violet) }
  validates :token,  length: { is: 32 }
  validates :search, inclusion: { in: 0..3 }
  validates :who,    inclusion: { in: %w(man woman all) }
  validates :how,    inclusion: { in: 1..3 }

  after_initialize do
    self.token ||= generate_token
    self.name  ||= self.gender == 'man' ? 'Аноним' : 'Анонимка'
  end

  after_save do
    my_clients do |client|
      client[ :user ].reload
      client.call_method( :activateSearch, self ) if self.search > 0 and self.who_changed?
    end
  end

  before_destroy do
    self.contacts.each { |contact| contact.dialog.destroy }
    remove_avatar_image
  end

  def replace_avatar( avatar )
    remove_avatar_image
    update avatar: avatar
  end

  def remove_avatar
    remove_avatar_image
    update avatar: nil
  end

  def my_clients
    list = []
    clients.each do |client|
      if client[ :user ] and client[ :user ] == self
        list << client
        yield( client ) if block_given?
      end
    end
    list
  end

  def offline
    if my_clients.length == 0
      self.contacts.where( active: true ).each { |contact| contact.update( active: false ) }
      self.update online: false
      self.sync
    end
  end

  def access_level( client )
    if user = client[ :user ]
      return :owner if user == self
      return :contact if self.contacts_users.include?( user )
    end
    :unknown
  end

  private

    def remove_avatar_image
      if self.avatar
        Cloudinary::Api.delete_resources [ self.avatar.split( '/' )[1] ]
      end
    end

    def generate_token
      begin
        token = SecureRandom.hex 16
      end while User.exists?( token: token )
      token
    end

end
