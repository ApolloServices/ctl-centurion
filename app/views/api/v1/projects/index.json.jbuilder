json.success true
json.message nil
json.status 200
json.content @projects do |project|
  json.id project.id
  json.name project.name
  json.project_number project.project_number
  json.location project.location
  json.project_authority project.project_authority
  json.project_authority_code project.project_authority_code
  json.latitude project.latitude
  json.longitude project.longitude
  json.status project.status
  json.client_line_1 project.client_line_1
  json.client_line_2 project.client_line_2
  json.client_line_3 project.client_line_3
  json.job_line_1 project.job_line_1
  json.job_line_2 project.job_line_2
  json.job_line_3 project.job_line_3
  json.created_at project.created_at
  json.updated_at project.updated_at
end