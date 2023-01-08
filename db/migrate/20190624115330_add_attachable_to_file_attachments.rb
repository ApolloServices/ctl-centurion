class AddAttachableToFileAttachments < ActiveRecord::Migration[5.2]
  def up
    change_table :file_attachments do |t|
      t.references :attachable, polymorphic: true
    end
  end

  def down
    change_table :file_attachments do |t|
      t.remove_references :attachable, polymorphic: true
    end
  end
end
