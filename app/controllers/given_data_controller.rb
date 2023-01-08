class GivenDataController < ApplicationController
  before_action :set_project
  def index
    @given_data = @project.given_data
  end

  def new
    @given_datum = @project.given_data.new
  end

  def edit
    @given_datum = GivenDatum.find(params[:id])
  end

  def show
    @given_datum = GivenDatum.find(params[:id])
  end

  def update
    @given_datum = GivenDatum.find(params[:id])
    if @given_datum.update(given_data_params)
      flash[:notice] = 'Given Data is successfully updated'
      redirect_to project_given_data_path
    else
      flash[:alert] = @given_datum.errors.full_messages.to_sentence
      redirect_to edit_project_given_datum(@project.id,@given_datum.id)
    end
  end

  def create
    @given_datum = @project.given_data.new(given_data_params)
    if @given_datum.save
      flash[:notice] = 'Given Data is successfully saved'
      redirect_to project_given_data_path(@project)
    else
      flash[:alert] = @given_datum.errors.full_messages.to_sentence
      redirect_to new_project_given_datum
    end
  end

  def toggle_status
    @given_datum = GivenDatum.find(params[:given_datum_id])
    @given_datum.toggle!(:status)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @given_datum = GivenDatum.find(params[:id])
    if @given_datum.destroy
      flash[:notice] = 'Given Data is successfully deleted'
    else
      flash[:alert] = 'Something is wrong'
    end
    redirect_to project_given_data_path
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def given_data_params
    params.require(:given_datum).permit(:file_type, :project_id, :date, :description, :subject, :to, :from, :in_or_out, :attachment_list, files: [])
  end

end
