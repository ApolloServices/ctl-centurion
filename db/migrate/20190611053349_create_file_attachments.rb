class CreateFileAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :file_attachments do |t|

      t.text :data,         :null => false
      t.string :filename
      t.string :mime_type
      t.string :extension
      t.references :field_note, foreign_key: true
      t.timestamps
    end
  end
end
