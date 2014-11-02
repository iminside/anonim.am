class CreateMessagephotos < ActiveRecord::Migration
  def change
    create_table :messagephotos do |t|
      t.belongs_to :message
      t.belongs_to :photo

      t.timestamps

      t.index :message_id
      t.index :photo_id
    end
  end
end
