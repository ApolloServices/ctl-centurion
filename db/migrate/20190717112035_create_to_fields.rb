class CreateToFields < ActiveRecord::Migration[5.2]
  def change
    create_table :to_fields do |t|
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
