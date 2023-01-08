class AddDayJobFileIdToFileAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :file_attachments, :day_job_file_id, :integer
  end
end
