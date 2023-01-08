class Api::V1::ProjectsController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    company = current_company
    if company.nil?
      render json: {success: false, message: 'Company not found.', status: 404 , content: []}
      return
    end
    @projects = company.try(:projects).try(:active).order(created_at: :desc)
  end

  def create_api_params
    parms = ApiParam.new(data: params)
    if parms.save
      render json: {success: true, message: 'Params created', status: 200}
    else
      render json: {success: false, message: 'Params rejected.', status: 404}
    end
  end

  def update
    ApiParam.create(data: params)
    project = Project.find_by_project_number(params[:project_project_number])
    if project.nil?
      render json: {success: false, message: 'Project not found.', status: 404 , content: []}
      return
    end
    if project.update(project_params)

      instrument_name = params[:instrument_name]
      survey_name = params[:survey_name]
      controller_name = params[:controller_name]
      if instrument_name.present?
        instrument = find_or_create_instrument(instrument_name)
        project.update_attributes(instrument_id: instrument.id)
      end

      if survey_name.present?
        survey = find_or_create_survey(survey_name)
        project.update_attributes(survey_id: survey.id)
      end

      if controller_name.present?
        survey_controller = find_or_create_controller(controller_name)
        project.update_attributes(survey_controller_id: survey_controller.id)
      end

      render json: {success: true, message: 'Project has been updated Successfully.', status: 200, content: [] }
    else
      render json: {success: false, message: project.errors.full_messages.uniq.join(', '), status: 404 , content: []}
    end
  end

  def create
    ApiParam.create(data: params)
    @project = Project.new(project_params)
    instrument_name = params[:instrument_name]
    survey_name = params[:survey_name]
    controller_name = params[:controller_name]
    if instrument_name.present?
      @project.instrument = find_or_create_instrument(instrument_name)
    end

    if survey_name.present?
      @project.survey = find_or_create_survey(survey_name)
    end

    if controller_name.present?
      @project.survey_controller = find_or_create_controller(controller_name)
    end

    if @project.save
      render json: {success: true, message: 'Project is created Successfully.', status: 201, content: [] }
    else
      render json: {success: false, message: @project.errors.full_messages.uniq.join(', '), status: 400 , content: []}
    end
  end

  private

  def project_params
    params.permit(:project_number, :name, :location, :project_client_code, :project_authority, :project_authority_code, :client_line_1, :client_line_2, :client_line_3, :job_line_1, :job_line_2, :job_line_3,:text_angle, :instrument_id, :client_short_name, :surveyor_id, :survey_controller_id, :user_id , :client_id)
  end

  def find_or_create_instrument(instrument_name)
    instrument = Instrument.where(name: instrument_name).last
    if instrument.blank?
      instrument = Instrument.create(name: instrument_name)
    end
    instrument
  end

  def find_or_create_survey(survey_name)
    survey = Servay.where(name: survey_name).last
    if survey.blank?
      survey = Servay.create(name: survey_name)
    end
    survey
  end

  def find_or_create_controller(controller_name)
    controller = ServayController.where(name: controller_name).last
    if controller.blank?
      controller = ServayController.create(name: controller_name)
    end
    controller
  end
end