class Api::V1::SurveyControllersController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    @controllers = current_company.survey_controllers
  end
end