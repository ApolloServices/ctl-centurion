json.set! :data do
  json.array! @stylesheets do |stylesheet|
    json.partial! 'stylesheets/stylesheet', stylesheet: stylesheet
    json.url  "
              #{link_to 'Show', stylesheet }
              #{link_to 'Edit', edit_stylesheet_path(stylesheet)}
              #{link_to 'Destroy', stylesheet, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end