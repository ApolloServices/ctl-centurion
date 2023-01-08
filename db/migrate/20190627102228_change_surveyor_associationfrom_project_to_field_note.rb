class ChangeSurveyorAssociationfromProjectToFieldNote < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :surveyor_id, :integer
    add_column :field_notes, :surveyor_id, :integer
  end
end
