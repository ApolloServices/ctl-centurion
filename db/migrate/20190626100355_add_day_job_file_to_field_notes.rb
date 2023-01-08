class AddDayJobFileToFieldNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :field_notes, :day_job_file, :string
  end
end
