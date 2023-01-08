class ChangeFieldsInProject < ActiveRecord::Migration[5.2]
  def up
    remove_column :projects, :project_drawing_title, :text
    remove_column :projects, :project_drawing_description, :text

    add_column :projects, :client_line_1, :string
    add_column :projects, :client_line_2, :string
    add_column :projects, :client_line_3, :string
    add_column :projects, :job_line_1, :string
    add_column :projects, :job_line_2, :string
    add_column :projects, :job_line_3, :string
    add_column :projects, :text_angle, :integer
  end
  def down
    add_column :projects, :project_drawing_title, :text
    add_column :projects, :project_drawing_description, :text

    remove_column :projects, :client_line_1, :string
    remove_column :projects, :client_line_2, :string
    remove_column :projects, :client_line_3, :string
    remove_column :projects, :job_line_1, :string
    remove_column :projects, :job_line_2, :string
    remove_column :projects, :job_line_3, :string
    remove_column :projects, :text_angle, :integer
  end
end
