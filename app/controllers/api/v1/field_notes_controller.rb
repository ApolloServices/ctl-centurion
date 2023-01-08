class Api::V1::FieldNotesController < ApiController

  skip_before_action :verify_authenticity_token
  before_action :set_project, only: [:index, :create, :update]

  def index

    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects', status: 400, content: []}
      return
    end
    field_notes = @project.try(:field_notes)
    if field_notes.blank?
      render json: {success: false, message: 'There are no field notes', status: 404, content: []} and return
    end
    if params[:return_all].present? && params[:return_all] == "true"
      @field_notes = field_notes
    else
      # last_requested_at can be nil most of the times, because this field is populated for the first when this action is called, so we have to pass some
      # date to bypass error that will be generated when this field is nil
      from_date = @project.field_notes_last_requested_at.present? ? @project.field_notes_last_requested_at : @project.field_notes.first.created_at.weeks_ago(2)
      @field_notes = field_notes.where(created_at: from_date..Time.current)
      update_last_requested_at
    end
  end

  def update
    # ApiParam.create(data: params)
    @field_note = FieldNote.find_by_file_id(params[:file_id])
    if @field_note.blank?
      render json: {success: false, message: 'There are no field note on give file_id',  status: 404, content: []} and return
    end

    if @field_note.project != @project
      render json: {success: false, message: 'Field Note does not belong to given project.', status: 403, content: []} and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: []} and return
    end

    if params[:surveyor_id]
      surveyor = @project.company.users.where(two_digit_id: params[:surveyor_id]).first

      if surveyor
        @field_note.surveyor_id = surveyor.id
      else
        render json: {success: false, message: 'There is no Surveyor found on the given surveyor_id', status: 404, content: []} and return
      end

    end

    if @field_note.update(note_params)
      render json: {success: true, message: 'Field Note is updated Successfully.', status: 200, content: []}
    else
      render json: {success: false, message: @field_note.errors.full_messages.to_sentence, status: 403, content: []}
    end
  end

  def create
    # ApiParam.create(data: params)
    @field_note = @project.field_notes.new(note_params)

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: []} and return
    end

    surveyor = @project.company.users.where(two_digit_id: params[:surveyor_id]).first
    if surveyor.present?
      @field_note.surveyor_id = surveyor.id
    else
      render json: { success: false, message: 'There is no Surveyor found on the given surveyor id', status: 404, content: [] } and return
    end
    if @field_note.save
      render json: { success: true, message: 'Field Note is Created Successfully.', status: 200, content: [] }
    else
      render json: { success: false, message: @field_note.errors.full_messages.uniq.join(', '), status: 404, content: [] }
    end
  end

  private

  def note_params
    params.permit(:file_type, :date, :description, :summary, :project_id, :additional_processing, :detail, :file_id, :surveyor_id, :additional_1,:additional_2,:additional_3,:day_job_file,:additional_4, :job_file, :pdf_notes_file, :pdf_file, supporting_documents: [])
  end

  def set_project
    @project = Project.find_by_project_number(params[:project_project_number])
    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end
  end

  def update_last_requested_at
    @project.update_attributes(field_notes_last_requested_at: Time.current)
  end
end