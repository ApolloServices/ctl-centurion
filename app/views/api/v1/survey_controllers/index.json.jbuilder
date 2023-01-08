json.success true
json.message nil
json.status 200
json.content @controllers do |s|
  json.two_digit_id s.two_digit_id || ''
  json.name s.name || ''
  json.controller_type s.controller_type || ''
  json.serial_number s.serial_number || ''
  json.software_version s.software_version || ''
  json.controller_login s.controller_login || ''
  json.created_at s.created_at || ''
  json.updated_at s.updated_at || ''
end