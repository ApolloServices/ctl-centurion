class AddSurveyorFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :initials, :string
    add_column :users, :two_digit_id, :string
  end
end
