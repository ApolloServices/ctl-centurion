class CreateApiParams < ActiveRecord::Migration[5.2]
  def change
    create_table :api_params do |t|

      t.text :data
      t.timestamps
    end
  end
end
