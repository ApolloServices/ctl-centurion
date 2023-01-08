class CreateFieldNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :field_notes do |t|
      t.string :file_id
      t.string :file_type
      t.string :day_job
      t.date :date
      t.text :description
      t.text :summary
      t.text :detail
      t.boolean :additional_processing
      t.string :additional_1
      t.string :additional_2
      t.string :additional_3
      t.string :additional_4
      t.timestamps
    end
  end
end
