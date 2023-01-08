class RenameSurveyToSurveyor < ActiveRecord::Migration[5.2]
  def change
    rename_table :surveys, :surveyors
    rename_column :jobs, :survey_id, :surveyor_id
  end
end
