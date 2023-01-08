class Api::V1::GivenDataController < ApiController

  before_action :set_project

  skip_before_action :verify_authenticity_token
  def update
    ApiParam.create(data: params)
    @given_datum = GivenDatum.find(params[:id])
    if @given_datum.update(given_data_params)
      render json: {success: true, message: 'Given Data has been updated Successfully.', status: 200, content: []}
    else
      render json: {success: false, message: @given_datum.errors.full_messages.to_sentence, status: 404, content: []}
    end
  end

  def create
    ApiParam.create(data: params)
    if @project.nil?
      render json: {success: false, message: 'Invalid project number', status: 404, content: []} and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: []} and return
    end

    @given_datum = @project.given_data.new(given_data_params)
    if params[:attachment_list].present?
      list = JSON.parse params[:attachment_list]
      @given_datum.attachment_list = list
    end
    if @given_datum.save
      render json: { success: true, message: 'Given Data has been created Successfully.', status: 201, content: []}
    else
      render json: {success: true, message: @given_datum.errors.full_messages.uniq.join(', '), status: 404, content: []}
    end
  end

  private

  def set_project
    @project = Project.find_by_project_number(params[:project_project_number])
    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end
  end

  def given_data_params
    params.permit(:file_type, :date, :description, :subject, :to, :from, :in_or_out, files: [])
  end
end