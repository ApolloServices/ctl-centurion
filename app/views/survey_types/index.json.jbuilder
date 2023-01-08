json.set! :data do
  json.array! @survey_types do |survey_type|
    json.partial! 'survey_types/survey_type', survey_type: survey_type
    json.url  "
              #{link_to 'Show', survey_type }
              #{link_to 'Edit', edit_survey_type_path(survey_type)}
              #{link_to 'Destroy', survey_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end