json.success true
json.message nil
json.status 200
json.content @instruments do |s|
  json.two_digit_id s.two_digit_id || ''
  json.name s.name || ''
  json.instrument_type s.instrument_type || ''
  json.serial_number s.serial_number || ''
  json.firmware_version s.firmware_version || ''
  json.service_due_date s.service_due_date.strftime('%Y-%m-%d') || ''
  json.created_at s.created_at || ''
  json.updated_at s.updated_at || ''
end