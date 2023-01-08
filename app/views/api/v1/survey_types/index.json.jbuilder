if Rails.env.development?
  domain = "localhost:3000"
else
  domain = "https://ctl-centurion.herokuapp.com/"
end
json.success true
json.message @survey_types.present? ? nil : 'There are currently no survey types present.'
json.status 200
json.content @survey_types do |s|
  json.id s.id
  json.two_digit_id s.two_digit_id
  json.description s.description
  json.company_id s.company_id
  json.created_at s.created_at
  json.updated_at s.updated_at
  array1 = []
  s.default_stylesheets.each do |ds|
    hash1 = {}
    hash1[:stylesheet] = ds
    hash1[:stylesheet_file] = ds.file.attached? ? "#{domain}#{url_for(ds.file)}" : 'Not attached'
    hash1[:slx_template] = ds.slx_template.attached? ? "#{domain}#{url_for(ds.slx_template)}"  : 'Not attached'
    array1 << hash1
  end
  array2 = []
  s.optional_stylesheets.each do |os|
    hash2 = {}
    hash2[:stylesheet] = os
    hash2[:stylesheet_file] = os.file.attached? ? "#{domain}#{url_for(os.file)}" : 'Not attached'
    hash2[:slx_template] = os.slx_template.attached? ? "#{domain}#{url_for(os.slx_template)}" : 'Not attached'
    array2 << hash2
  end

  json.default_stylesheets array1
  json.optional_stylesheets array2
end