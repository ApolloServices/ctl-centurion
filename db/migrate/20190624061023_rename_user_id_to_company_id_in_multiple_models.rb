class RenameUserIdToCompanyIdInMultipleModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :user_id, :company_id
    rename_column :surveyors, :user_id, :company_id
    rename_column :survey_controllers, :user_id, :company_id
    rename_column :survey_types, :user_id, :company_id
    rename_column :instruments, :user_id, :company_id
    rename_column :clients, :user_id, :company_id
  end
end
