class Api::V1::CorrespondencesController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :set_project

  def create
    ApiParam.create(data: params)
    if @project.nil?
      render json: {success: false, message: 'Invalid project number', status: 404, content: [] } and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: [] } and return
    end

    correspondence = @project.correspondences.new(correspondence_params)
    if correspondence.save
    render json: {success: true, message: 'Correspondence has been created successfully.', status: 201, content: [] }
    else
      render json: {success: false, message: correspondence.errors.full_messages.uniq.join(', '), status: 404, content: [] }
    end
  end

  private

  def correspondence_params
    params.permit(:file_type,:project_id, :description, :subject, :to, :from, :in_or_out, :date)
  end

  def set_project
    @project = Project.find_by_project_number(params[:project_project_number])
    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end
  end

end