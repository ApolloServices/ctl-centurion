class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :client_code
      t.string :abn
      t.string :unique_id
      t.string :accounts_contact_email
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
