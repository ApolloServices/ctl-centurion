class RenameServayToSurvey < ActiveRecord::Migration[5.2]
  def change
    rename_table :servays, :surveys
    rename_table :servay_controllers, :survey_controllers
    rename_column :jobs, :servay_id, :survey_id
    rename_column :jobs, :servay_controller_id, :survey_controller_id
  end
end
