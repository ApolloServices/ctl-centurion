class CreateCorrespondences < ActiveRecord::Migration[5.2]
  def change
    create_table :correspondences do |t|
      t.string :file_id
      t.string :file_type
      t.date :date
      t.text :description
      t.string :subject
      t.string :to
      t.string :from
      t.string :in_or_out
      t.text :attachment_list, array: true, default: []
      t.timestamps
    end
  end
end
