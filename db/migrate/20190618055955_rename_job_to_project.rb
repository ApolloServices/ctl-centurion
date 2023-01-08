class RenameJobToProject < ActiveRecord::Migration[5.2]
  def change
    rename_table :jobs, :projects
    rename_column :field_notes, :job_id, :project__id
    rename_column :given_data, :job_id, :project__id
    rename_column :items, :job_id, :project__id
    rename_column :notes, :job_id, :project__id
    rename_column :correspondences, :job_id, :project__id
  end
end
