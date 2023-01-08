class CreateStylesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :stylesheets do |t|

      t.string :unique_id
      t.string :stylesheet_type
      t.string :path
      t.string :name
      t.timestamps
    end
  end
end
