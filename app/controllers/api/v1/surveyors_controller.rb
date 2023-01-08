class Api::V1::SurveyorsController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    @surveyors = current_company.users
  end
end