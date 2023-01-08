class RenameJobNumberToProjectNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :job_number, :project_number
    rename_column :field_notes, :project__id, :project_id
    rename_column :given_data, :project__id, :project_id
    rename_column :items, :project__id, :project_id
    rename_column :notes, :project__id, :project_id
    rename_column :correspondences, :project__id, :project_id
  end
end
