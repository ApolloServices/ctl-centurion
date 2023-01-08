class Api::V1::SurveyTypesController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    @survey_types = current_user.try(:company).try(:survey_types).includes(default_stylesheets: [file_attachment: :blob], optional_stylesheets: [file_attachment: :blob])
  end

end