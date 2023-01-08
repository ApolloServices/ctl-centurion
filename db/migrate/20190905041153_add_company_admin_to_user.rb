class AddCompanyAdminToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company_admin, :boolean, default: false
  end
end
