class AddServayControllerIdToJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :servay_controller, foreign_key: true
    add_reference :jobs, :user, foreign_key: true
  end
end
