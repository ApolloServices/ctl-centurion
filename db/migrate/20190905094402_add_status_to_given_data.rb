class AddStatusToGivenData < ActiveRecord::Migration[5.2]
  def change
    add_column :given_data, :status, :boolean, default: true
  end
end
