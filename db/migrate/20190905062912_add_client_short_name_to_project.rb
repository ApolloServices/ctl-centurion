class AddClientShortNameToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :client_short_name, :string
  end
end
