json.extract! survey_controller, :id, :created_at, :updated_at, :name
json.url survey_controller_url(survey_controller, format: :json)
