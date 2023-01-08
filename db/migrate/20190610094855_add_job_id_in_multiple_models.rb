class AddJobIdInMultipleModels < ActiveRecord::Migration[5.2]
  def change
    add_reference :given_data, :job, foreign_key: true
    add_reference :items, :job, foreign_key: true
    add_reference :notes, :job, foreign_key: true
    add_reference :correspondences, :job, foreign_key: true
  end
end
