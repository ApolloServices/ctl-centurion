class TimeSheetsController < ApplicationController

  def index
    # @projects = current_user.try(:company).try(:projects)
    @week = current_week
    @projects = set_projects(@week)
    @next_week_start = @week.last + 1.day
    @previous_week_start = @week.first - 1.day
  end

  def new
    @count = 1
    @projects = current_user.try(:company).try(:projects).where("name <> '' AND project_number <> ''")
    @date = Date.parse(params[:date])
    @selected = current_user.timings.where(date: @date.midnight..@date.end_of_day).pluck(:project_id)
  end

  def edit
    @date = Date.parse(params[:date])
    @project = Project.find(params[:project_id])
    @projects = current_user.company.projects.where("name <> '' AND project_number <> ''").order(:project_number)
    @time_sheet = Timing.find params[:id]
  end

  def update
    timing = Timing.find params[:id]
    if timing.update(single_timing_params)
      timing.calculate_total
      flash[:notice] = 'Time Sheet has been updated successfully'
    else
      flash[:alert] = timing.errors.full_messages.uniq.join(', ')
    end
    url = "/time_sheets/next?date=#{params[:date]}"
    redirect_to url
  end

  def create
    begin
      params[:timmings].each do |timing|
        timing[:date] = params[:date]
        timing[:surveyor_id] = current_user.id
        Timing.create(timing_params(timing))
      end
    rescue => e
      flash[:alert] = e
    end
    url = "/time_sheets/next?date=#{params[:date]}"
    redirect_to url
  end

  def next
    date = Date.parse(params[:date])
    @week = calculate_week(date, 'next')
    @projects = set_projects(@week)
    @next_week_start = @week.last + 1.day
    @previous_week_start = @week.first - 1.day
  end

  def previous
    date = Date.parse(params[:date])
    @week = calculate_week(date, 'prev')
    @projects = set_projects(@week)
    @next_week_start = @week.last + 1.day
    @previous_week_start = @week.first - 1.day
  end

  def add_form
    @old_count = params[:count].to_i
    @new_count = @old_count + 1
    @selected = params[:selected].reject { |item| item.blank? }
    @projects_count = current_user.company.projects.where("name <> '' AND project_number <> ''").count
  end

  def remove_form
    @old_count = params[:count].to_i
    @new_count = @old_count - 1
  end

  private

  def current_week
    date = Date.today.beginning_of_week
    return (date..date + 6.days).to_a
  end

  def calculate_week(given_date, type)
    date = given_date.beginning_of_week
    if type == 'next'
      (date..date + 6.days).to_a
    else
      (date..given_date).to_a
    end
  end

  private
  def timing_params(timing)
    timing.permit(:date, :field_duration, :office_duration, :travel_duration, :description, :surveyor_id, :project_id)
  end

  def single_timing_params
    params.require(:timings).permit(:date, :field_duration, :office_duration, :travel_duration, :description, :surveyor_id, :project_id)
  end

  def set_projects(week)
    @projects = current_user.company.projects.includes(:timings).where.not(timings: {project_id: nil}).where(timings: {surveyor_id: current_user.id}).where(timings: {date: week.first.midnight..week.last.end_of_day })
  end
end