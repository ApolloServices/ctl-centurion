require 'net/dav'
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  # autocomplete :project, :name
  def index
    @projects = current_user.company.projects
  end

  def new
    @project = current_user.company.projects.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
    @selected_tab = params[:selected_tab] if params[:selected_tab].present?
    respond_to do |format|
      format.html
      format.js {
        if @selected_tab.present? && @selected_tab != 'projects'
            render :js => "window.location.href='/projects/#{@project.id}/#{@selected_tab}'"
        else @selected_tab.present? && @selected_tab == 'projects'
          render :js => "window.location.href='/projects/#{@project.id}'"
        end
      }
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = 'Project is successfully updated'
      redirect_to projects_path
    else
      flash[:alert] = @project.errors.full_messages.to_sentence
      redirect_to edit_project_path(@project)
    end
  end

  def create

    company = current_user.company
    @project = company.projects.new(project_params)
    if @project.save
      flash[:notice] = 'Project is successfully saved'
      redirect_to projects_path
    else
      flash[:alert] = @project.errors.full_messages.to_sentence
      redirect_to new_project_path
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = 'Project is successfully destroyed'
    else
      flash[:alert] = 'Project is not deleted, please try again.'
    end
    redirect_to projects_path
  end

  def toggle_status
    @project = Project.find(params[:id])
    @project.toggle!(:status)
  end

  def autocomplete_name
    term = params[:term] ||= ''
    if !term.is_a?(String) || term.blank?
      return []
    end
    @projects = Project.select([:id, :name, :project_number]).where('name ILIKE ? OR project_number ILIKE ?',"#{term}%", "#{term}%")

    respond_to do |format|
      format.json { render json: @projects.map{|x| {id:x.id, value: "#{x.project_number} - #{x.name}"}} }
    end
  end
  def get_files
    project = Project.find(params[:id])
    field_notes = project.field_notes if project
    uploaded_files = project.field_notes.where.not(field_notes: {day_job_file: nil}).pluck(:day_job_file)
    file_names = []
    dav = Net::DAV.new("http://192.168.100.12/webdav/uploads/cc/cs/projects/#{project.id.to_s.rjust(4,'0')}-#{project.name.gsub(' ', '_')}/", :curl => false)
    dav.verify_server = false
    dav.credentials('clicktechlabs','clicktechlabs')
    dav.find('.',:recursive=>true,:suppress_errors=>true,:filename=>/\.pdf|\.xml$/) do | item |
      # puts "Checking: " + item.url.to_s
      # file_names << item.url.to_s.split('day_jobs/').last
      if uploaded_files.include?(item.url.to_s.split('day_jobs/').last)
        puts "uploaded, present"
      else
        puts "uploaded, not present"
      end
    end
    puts file_names
    redirect_to project

    # if project.present? && field_notes.present?
    #   field_notes.each do |field_note|
    #     source = URI(field_note.day_job_file.url)

    #     binding.pry

    #     Net::HTTP.start(source.host, source.port) do |http|
    #       req = Net::HTTP::Get.new source
    #       http.request(req) do |res|
    #         send_data res.read_body, filename: field_note.day_job_file.identifier, disposition: 'download'
    #       end
    #     end
    #   end
    # end
  end

  private

    def project_params
      params.require(:project).permit(:project_number, :name, :location, :project_client_code, :project_authority, :project_authority_code, :client_line_1, :client_line_2, :client_line_3, :job_line_1, :job_line_2, :job_line_3,:text_angle, :instrument_id, :client_short_name, :survey_controller_id, :company_id , :client_id)
    end
end
