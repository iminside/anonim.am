class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :token,  limit: 32
      t.string  :name
      t.string  :gender
      t.string  :color
      t.integer :image,  default: 0
      t.integer :search, default: 1, limit: 1
      t.boolean :online, default: false
      t.string  :who,    default: 'all'
      t.integer :how,    default: 1, limit: 1
      t.integer :sound,  default: 1, limit: 2
      t.string  :avatar, limit: 32
      
      t.timestamps

      t.index :token, unique: true
    end
  end
end
