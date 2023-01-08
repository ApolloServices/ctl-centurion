class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :job_number
      t.text :description
      t.string :location
      t.string :project_client_code
      t.string :project_authority
      t.string :project_authority_code
      t.text :project_drawing_title
      t.text :project_drawing_description
      t.timestamps
    end
  end
end
