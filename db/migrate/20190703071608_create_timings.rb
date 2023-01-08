class CreateTimings < ActiveRecord::Migration[5.2]
  def change
    create_table :timings do |t|
      t.datetime :entry_time
      t.datetime :exit_time
      t.string :duration

      t.timestamps
    end
  end
end
