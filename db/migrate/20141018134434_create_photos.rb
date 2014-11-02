class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :user
      t.string     :secret, limit: 32

      t.timestamps

      t.index :user_id
    end
  end
end
