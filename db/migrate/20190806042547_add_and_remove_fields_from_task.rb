class AddAndRemoveFieldsFromTask < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :notes, :text
    add_column :tasks, :surveyor_id, :integer
    add_column :tasks, :description, :text
    add_reference :tasks, :project, foreign_key: true

    remove_column :tasks, :person_name
    remove_column :tasks, :item_id
    remove_column :tasks, :status
  end

  def down
    add_column :tasks, :person_name, :string
    add_column :tasks, :item_id, :integer
    add_column :tasks, :status, :string

    remove_column :tasks, :due_date
    remove_column :tasks, :notes
    remove_column :tasks, :description
    remove_column :tasks, :project_id
    remove_column :tasks, :surveyor_id
  end
end
