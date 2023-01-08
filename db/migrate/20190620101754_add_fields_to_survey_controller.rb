class AddFieldsToSurveyController < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_controllers, :two_digit_id, :string
    add_column :survey_controllers, :controller_type, :string
    add_column :survey_controllers, :serial_number, :string
    add_column :survey_controllers, :software_version, :string
    add_column :survey_controllers, :controller_login, :string
  end
end
