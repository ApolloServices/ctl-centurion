class AddUserIdInThreeModels < ActiveRecord::Migration[5.2]
  def change
    add_reference :instruments, :user, foreign_key: true
    add_reference :servays, :user, foreign_key: true
    add_reference :servay_controllers, :user, foreign_key: true
  end
end
