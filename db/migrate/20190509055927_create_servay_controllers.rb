class CreateServayControllers < ActiveRecord::Migration[5.2]
  def change
    create_table :servay_controllers do |t|

      t.string :name
      t.timestamps
    end
  end
end
