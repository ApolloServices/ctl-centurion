class CreateSurveyTypeStylesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_type_stylesheets do |t|
      t.references :survey_type, foreign_key: true
      t.references :stylesheet, foreign_key: true
      t.string :stylesheet_type

      t.timestamps
    end
  end
end
