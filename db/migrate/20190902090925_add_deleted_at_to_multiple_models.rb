class AddDeletedAtToMultipleModels < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at

    add_column :field_notes, :deleted_at, :datetime
    add_index :field_notes, :deleted_at

    add_column :tasks, :deleted_at, :datetime
    add_index :tasks, :deleted_at

    add_column :to_fields, :deleted_at, :datetime
    add_index :to_fields, :deleted_at

    add_column :given_data, :deleted_at, :datetime
    add_index :given_data, :deleted_at

    add_column :calc_registers, :deleted_at, :datetime
    add_index :calc_registers, :deleted_at

    add_column :correspondences, :deleted_at, :datetime
    add_index :correspondences, :deleted_at

    add_column :clients, :deleted_at, :datetime
    add_index :clients, :deleted_at

    add_column :timings, :deleted_at, :datetime
    add_index :timings, :deleted_at

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :instruments, :deleted_at, :datetime
    add_index :instruments, :deleted_at

    add_column :stylesheets, :deleted_at, :datetime
    add_index :stylesheets, :deleted_at

    add_column :survey_types, :deleted_at, :datetime
    add_index :survey_types, :deleted_at

    add_column :survey_controllers, :deleted_at, :datetime
    add_index :survey_controllers, :deleted_at
  end
end
