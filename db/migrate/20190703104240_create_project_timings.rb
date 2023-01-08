class CreateProjectTimings < ActiveRecord::Migration[5.2]
  def change
    create_table :project_timings do |t|
        t.references :project, foreign_key: true
        t.references :timing, foreign_key: true
      t.timestamps
    end
  end
end
