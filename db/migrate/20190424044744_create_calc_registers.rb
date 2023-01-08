class CreateCalcRegisters < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_registers do |t|
      t.string :item
      t.text :details
      t.string :status
      t.string :person_name
      t.date :date
      t.timestamps
    end
  end
end
