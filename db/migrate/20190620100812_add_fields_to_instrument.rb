class AddFieldsToInstrument < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :two_digit_id, :string
    add_column :instruments, :instrument_type, :string
    add_column :instruments, :serial_number, :string
    add_column :instruments, :firmware_version, :string
    add_column :instruments, :service_due_date, :date
  end
end
