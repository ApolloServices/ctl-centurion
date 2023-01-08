class AddFieldsToCalcRegister < ActiveRecord::Migration[5.2]
  def up
    add_column :calc_registers, :subject, :string
    add_column :calc_registers, :calculation_record, :text
    add_column :calc_registers, :surveyor_id, :integer
    add_reference :calc_registers, :project, foreign_key: true

    remove_column :calc_registers, :person_name
    remove_column :calc_registers, :item
    remove_column :calc_registers, :details
  end

  def down
    add_column :calc_registers, :person_name, :string
    add_column :calc_registers, :item, :string
    add_column :calc_registers, :details, :string

    remove_column :calc_registers, :subject
    remove_column :calc_registers, :calculation_record
    remove_column :calc_registers, :surveyor_id
    remove_column :calc_registers, :project_id
  end
end
