class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.belongs_to :contact
      t.belongs_to :dialog
      t.boolean    :active,  default: false
      t.integer    :counter, default: 0
      
      t.timestamps
      
      t.index :user_id
    end
  end
end
