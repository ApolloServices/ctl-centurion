json.success true
json.message nil
json.status 200
json.content @surveyors do |s|
  json.two_digit_id s.two_digit_id || ''
  json.name s.name || ''
  json.initials s.initials || ''
  json.login s.email || ''
  json.created_at s.created_at || ''
  json.updated_at s.updated_at || ''
end