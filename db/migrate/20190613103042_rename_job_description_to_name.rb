class RenameJobDescriptionToName < ActiveRecord::Migration[5.2]
  def up
    rename_column :jobs, :description, :name
    change_column :jobs, :name, :string
  end
  def down
    rename_column :jobs, :name, :description
    change_column :jobs, :name, :string
  end
end
