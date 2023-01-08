class ReportingsController < ApplicationController

  def index
    @pagy_timings, @timings = pagy(current_user.timings.includes(:project), page: params[:page], items: 5)
    @pagy_projects, @projects = pagy(current_user.company.projects.includes(:timings), items: 5)
  end

  def search
    project_params = params[:projects]
    start_date = params[:start_date]
    end_date = params[:end_date]

    current_projects = current_user.company.projects.includes(:timings).where.not(timings: {project_id: nil})

    if start_date.present? && end_date.present? && project_params.blank?
      @projects = current_projects.where(timings: {date: start_date..end_date })
    elsif project_params.present? && start_date.nil? && end_date.nil?
      project_numbers = project_params.split(',')
      number_array = []
      project_numbers.each do |p|
        number_array << p.split(' - ').first
      end
      @pagy_projects, @projects, @projects = pagy(current_projects.where(project_number: number_array), page: params[:page], items: 5)
    else
      @pagy_projects, @projects = pagy(current_user.company.projects.includes(:timings), page: params[:page], items: 5)
    end
    respond_to do |format|
      format.js
    end
  end

  def autocomplete_user_name
    term = params[:term] ||= ''
    if !term.is_a?(String) || term.blank?
      return []
    end
    @users = current_user.company.users.select(:id, :first_name, :last_name, :two_digit_id, :initials).where('first_name ILIKE ? OR last_name ILIKE ? OR initials ILIKE ? OR two_digit_id ILIKE ?',"#{term}%", "#{term}%", "#{term}%", "#{term}%")

    respond_to do |format|
      format.json { render json: @users.map{|x| {id:x.id, value: "(#{x.name})#{x.two_digit_id} - #{x.initials.present? ? x.initials : x.full_name_initials}"}} }
    end
  end

  def search_by_user
    user_params = params[:user]
    if user_params.present?
      user = current_user.company.users.find_by_two_digit_id(user_params.split(')').last.split(' - ').first)
      @pagy_timings, @timings =  pagy(user.timings.includes(:project), items: 5)
      @name = user.name + "'s"
    else
      @pagy_timings, @timings = pagy(current_user.timings.includes(:project), page: params[:page], items: 5)
      @name = 'Your'
    end
    respond_to do |format|
      format.js
    end
  end

  def download_csv
    @timings = current_user.timings.includes(:project)
    respond_to do |format|
      format.csv { send_data @timings.to_csv }
    end
  end

end