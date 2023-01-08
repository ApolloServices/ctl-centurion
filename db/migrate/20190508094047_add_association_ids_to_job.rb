class AddAssociationIdsToJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :servay, foreign_key: true
    add_reference :jobs, :instrument, foreign_key: true
  end
end
