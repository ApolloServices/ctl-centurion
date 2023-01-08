class Api::V1::TimingsController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    @timings = Timing.all
  end

  def create
    project = Project.find_by(latitude: params[:latitude])
    # if params[:enter_exit] == 'ENTER'
      @entry = Timing.create(entry_time: params[:entry_time])
      @project_timing = ProjectTiming.create(project_id: project.id, timing_id: @entry.id)
      render 'api/v1/timings/index', locals: {rows: @entry}
    # end
  end

  def update
    @timing = Timing.find(params[:timing_id])
    project = Project.find_by(latitude: params[:latitude])
    @timing.update!(exit_time: params[:exit_time])
    @timing.update!(duration: params[:duration])
    render 'api/v1/timings/index', locals: {rows: @timing}
  end

end