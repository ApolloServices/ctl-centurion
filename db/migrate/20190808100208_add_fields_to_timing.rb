class AddFieldsToTiming < ActiveRecord::Migration[5.2]
  def change
    add_reference :timings, :project, foreign_key: true
    add_column :timings, :surveyor_id, :integer
    add_column :timings, :description, :text
    add_column :timings, :travel_duration, :float, default: 0
    add_column :timings, :office_duration, :float, default: 0
    add_column :timings, :field_duration, :float, default: 0
    add_column :timings, :total_duration, :float, default: 0
    add_column :timings, :date, :date
  end
end
