if Rails.env.development?
  domain = "localhost:3000"
else
  domain = "https://ctl-centurion.herokuapp.com/"
end
json.success true
json.message @to_fields.present? ? nil : 'There are no new to fields for this project'
json.status 200
json.content @to_fields do |to_field|
  json.record_id to_field.record_id
  json.extension to_field.extension
  json.status to_field.status
  json.notes to_field.notes
  json.date to_field.date
  json.initials_of_surveyor to_field.try(:surveyor).try(:name)
  json.file_url to_field.file.attached? ? "#{domain}#{url_for(to_field.file)}" : 'Not attached'
  json.file_name to_field.file.attached? ? to_field.file.filename : 'No file'
end