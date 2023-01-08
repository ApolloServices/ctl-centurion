class CreateSurveyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_types do |t|

      t.string :two_digit_id
      t.string :description
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
