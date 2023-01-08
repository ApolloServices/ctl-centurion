if Rails.env.development?
  domain = "localhost:3000"
else
  domain = "https://ctl-centurion.herokuapp.com/"
end
json.success true
json.message @field_notes.present? ? nil : 'There are no new field notes for this project'
json.status 200
json.content @field_notes do |field_note|
  json.id field_note.id
  json.file_id field_note.file_id
  json.received_date field_note.date
  json.description field_note.description
  json.created_at field_note.created_at
  json.updated_at field_note.updated_at
  json.file field_note.job_file.attached? ? "#{domain}#{url_for(field_note.job_file)}" : 'Not attached'
  json.hand_written_notes field_note.pdf_file.attached? ? "#{domain}#{url_for(field_note.pdf_file)}" : 'Not attached'
end