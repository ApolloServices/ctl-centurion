class AddLastRequestedAtToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :last_requested_at, :datetime
  end
end
