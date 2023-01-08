class CorrespondencesController < ApplicationController
  before_action :set_project
  def index
    @correspondences = @project.correspondences
  end

  def new
    @correspondence = @project.correspondences.new
  end

  def edit
    @correspondence = Correspondence.find(params[:id])
  end

  def show
    @correspondence = Correspondence.find(params[:id])
  end

  def update
    @correspondence = Correspondence.find(params[:id])
    if @correspondence.update(correspondence_params)
      flash[:notice] = 'Correspondence is successfully updated'
      redirect_to project_correspondences_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      redirect_to edit_project_correspondence_path(@project)
    end
  end

  def create
    @correspondence = @project.correspondences.new(correspondence_params)
    if @correspondence.save
      flash[:notice] = 'Correspondence is successfully saved'
      redirect_to project_correspondences_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      redirect_to new_project_correspondence_path(@project)
    end
  end

  def destroy
    @correspondence = Correspondence.find(params[:id])
    if @correspondence.destroy
      flash[:notice] = 'Correspondence is successfully deleted'
    else
      flash[:notice] = 'Something is wrong'
    end
    redirect_to project_correspondences_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def correspondence_params
    params.require(:correspondence).permit(:file_type,:project_id, :description, :subject, :to, :from, :in_or_out, :date, files: [])
  end
end
