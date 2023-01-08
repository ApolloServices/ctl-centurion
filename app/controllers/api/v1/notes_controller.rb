class Api::V1::NotesController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :set_project

  def create
    ApiParam.create(data: params)
    if @project.nil?
      render json: {success: false, message: 'Invalid project number', status: 400, content: [] } and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: [] } and return
    end

    note = @project.notes.new(notes_params)
    if note.save
      render json: {success: true, message: 'Note has been successfully created.', status: 200, content: [] }
    else
      render json: {success: false, message: note.errors.full_messages.uniq.join(', '), status: 400, content: [] }
    end
  end

  private

  def notes_params
    params.permit(:item,:project_id, :instructions, :index)
  end

  def set_project
    @project = Project.find_by_project_number(params[:project_project_number])
    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end
  end

end