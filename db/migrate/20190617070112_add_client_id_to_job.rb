class AddClientIdToJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :client, foreign_key: true
  end
end
