class CreateSurveyTypeOptionalStylesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_type_optional_stylesheets do |t|

      t.references :survey_type, foreign_key: true
      t.references :stylesheet, foreign_key: true
      t.timestamps
    end
  end
end
