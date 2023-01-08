class Api::V1::ToFieldsController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :set_project, only: [:index, :create, :destroy, :update]

  def index
    if @project.nil?
      render json: {success: false, message: 'Invalid project number', status: 404, content: []} and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: []} and return
    end

    to_fields = @project.try(:to_fields)

    if to_fields.blank?
      render json: {success: false, message: 'There are no to fields', status: 404, content: []} and return
    end

    if params[:return_all].present? && params[:return_all] == "true"
      @to_fields = to_fields
    else
      # last_requested_at can be nil most of the times, because this field is populated for the first when this action is called, so we have to pass some
      # date to bypass error that will be generated when this field is nil
      from_date = @project.to_fields_last_requested_at.present? ? @project.to_fields_last_requested_at : @project.to_fields.first.created_at.weeks_ago(2)
      @to_fields = to_fields.where(created_at: from_date..Time.current)
      update_last_requested_at
    end
  end

  def create
    ApiParam.create(data: params)
    @to_field = @project.to_fields.new(to_fields_params)
    surveyor = @project.company.users.where(two_digit_id: params[:surveyor_id]).first
    if surveyor.present?
      @to_field.surveyor_id = surveyor.id
    else
      render json: {success: false, message: 'There is no Surveyor found on the given surveyor_id', status: 404, content: []} and return
    end
    if @to_field.save
      render json: {success: true, message: 'To field is created successfully.', status: 200, content: []}
    else
      render json: {success: false, message: @to_fields.errors.full_messages.uniq.join(', '), status: 404, content: []}
    end
  end

  def destroy
    if @project.nil?
      render json: {success: false, message: 'Invalid project number', status: 404, content: []} and return
    end

    if !check_company_matching
      render json: {success: false, message: 'User token does not match with company projects.', status: 403, content: []} and return
    end

    @to_field = ToField.find_by_record_id(params[:record_id])

    if @to_field.nil?
      render json: {success: false, message: 'No To Field found on the given Record ID', status: 404, content: []} and return
    end

    if @project != @to_field.project
      render json: {success: false, message: 'To Field does not belong to this project.', status: 403, content: []} and return
    end

    if @to_field.destroy
      render json: {success: true, message: 'To Field is deleted Successfully.', status: 200, content: []}
    else
      render json: {success: false, message: 'To Field is not deleted, please try again', status: 400, content: []}
    end
  end

  def update
    ApiParam.create(data: params)
    @to_field = ToField.find_by_record_id(params[:record_id])

    if @to_field.nil?
      render json: {success: false, message: 'There is no To Field found on the provided Record ID', status: 404, content: []} and return
    end

    surveyor = @project.company.users.where(two_digit_id: params[:surveyor_id]).first
    if surveyor.present?
      @to_field.surveyor_id = surveyor.id
    else
      render json: {success: false, message: 'There is no Surveyor found on the given surveyor_id', status: 404, content: []} and return
    end

    @to_field.status = params[:status]
    if @to_field.save
      render json: {success: true, message: 'To field is updated successfully.', status: 200, content: []}
    else
      render json: {success: false, message: @to_fields.errors.full_messages.uniq.join(', '), status: 404, content: []}
    end
  end

  private

  def to_fields_params
    params.permit(:project_id, :file, :extension, :status, :notes, :date)
  end

  def set_project
    @project = Project.find_by_project_number(params[:project_project_number])
    if @project.nil?
      render json: {success: false, message: 'Invalid Project Number', status: 404, content: []} and return
    end
  end

  def update_last_requested_at
    @project.update_attributes(to_fields_last_requested_at: Time.current)
  end
end