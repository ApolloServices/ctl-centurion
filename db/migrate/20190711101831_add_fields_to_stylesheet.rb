class AddFieldsToStylesheet < ActiveRecord::Migration[5.2]
  def change
    add_column :stylesheets, :label, :string
    add_column :stylesheets, :output_extension, :string
    add_column :stylesheets, :create_slx, :boolean, default: false
  end
end
