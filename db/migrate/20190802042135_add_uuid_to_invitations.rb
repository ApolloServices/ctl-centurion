class AddUuidToInvitations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    add_column :invitations, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    add_column :companies, :uuid, :uuid, default: "uuid_generate_v4()", null: false
  end
end
