class Api::V1::InstrumentsController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    @instruments = current_company.instruments
  end
end