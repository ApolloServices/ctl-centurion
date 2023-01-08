class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company_name, :string
    add_column :users, :address, :string
    add_column :users, :abn, :string
    add_column :users, :accounts_contact_name, :string
    add_column :users, :accounts_contact_number, :string
  end
end
