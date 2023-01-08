class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|

      t.string :person_name
      t.string :status
      t.datetime :completed_date
      t.references :item
      t.timestamps
    end
  end
end
