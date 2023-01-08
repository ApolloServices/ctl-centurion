class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :item
      t.text :instructions
      t.integer :index
      t.timestamps
    end
  end
end
