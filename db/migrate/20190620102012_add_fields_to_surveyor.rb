class AddFieldsToSurveyor < ActiveRecord::Migration[5.2]
  def change
    add_column :surveyors, :two_digit_id, :string
    add_column :surveyors, :initials, :string
    add_column :surveyors, :login, :string
    add_column :surveyors, :password, :string
  end
end
