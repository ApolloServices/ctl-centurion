class AddCompanyIdToStylesheet < ActiveRecord::Migration[5.2]
  def change
    add_reference :stylesheets, :company, foreign_key: true
    add_reference :stylesheets, :user, foreign_key: true
  end
end
