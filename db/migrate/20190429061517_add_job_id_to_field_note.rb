class AddJobIdToFieldNote < ActiveRecord::Migration[5.2]
  def change
    add_reference :field_notes, :job, foreign_key: true
  end
end
