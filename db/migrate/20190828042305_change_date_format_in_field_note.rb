class ChangeDateFormatInFieldNote < ActiveRecord::Migration[5.2]
  def up
    change_column :field_notes, :date, :datetime
  end

  def down
    change_column :field_notes, :date, :date
  end
end
