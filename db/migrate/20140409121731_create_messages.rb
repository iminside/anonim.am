class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :dialog
      t.belongs_to :user
      t.string     :text
      
      t.timestamps

      t.index :user_id
      t.index :dialog_id
    end
  end
end
