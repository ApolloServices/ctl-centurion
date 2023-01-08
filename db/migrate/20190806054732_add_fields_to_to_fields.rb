class AddFieldsToToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :to_fields, :record_id, :string
    add_column :to_fields, :extension, :string
    add_column :to_fields, :status, :string
    add_column :to_fields, :notes, :text
    add_column :to_fields, :surveyor_id, :integer
    add_column :to_fields, :date, :datetime
  end
end
