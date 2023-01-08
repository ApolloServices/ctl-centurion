desc "Default stylesheets should be assigned to survey types"
task assign_default_stylesheets: :environment do
  companies = Company.all

  companies.each do |company|
    survey_types = company.survey_types
    stylesheets = company.stylesheets.default_stylesheets
    survey_types.each do |survey_type|
      survey_type.default_stylesheets = [] if survey_type.default_stylesheets.present?
      survey_type.default_stylesheets = stylesheets
      if survey_type.save
        puts "survey type with id = #{survey_type.id}, got updated"
      else
        puts "error - id: #{survey_type.id}"
      end
    end

  end

end