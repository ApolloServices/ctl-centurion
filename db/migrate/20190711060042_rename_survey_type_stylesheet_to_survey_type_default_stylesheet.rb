class RenameSurveyTypeStylesheetToSurveyTypeDefaultStylesheet < ActiveRecord::Migration[5.2]
  def change
    remove_column :survey_type_stylesheets, :stylesheet_type, :string
    rename_table :survey_type_stylesheets, :survey_type_default_stylesheets
  end
end
