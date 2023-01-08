class ChangeAndAddFieldsInProject < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :last_requested_at, :field_notes_last_requested_at
    add_column :projects, :to_fields_last_requested_at, :datetime
  end
end
