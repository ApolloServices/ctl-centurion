class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.string :item_name
      t.text :details
      t.timestamps
    end
  end
end
