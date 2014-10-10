class CreateDialogs < ActiveRecord::Migration
  def change
    create_table :dialogs do |t|
      t.timestamps
    end
  end
end