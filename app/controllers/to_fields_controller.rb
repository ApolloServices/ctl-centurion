class ToFieldsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @to_fields = @project.to_fields
  end

  def edit
    @project = Project.find(params[:project_id])
    @to_field = ToField.find_by_id(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @to_field = ToField.find(params[:id])
    if @to_field.update(to_fields_params)
      flash[:notice] = 'To Field has been successfully updated'
      redirect_to project_to_fields_path(@project)
    else
      flash[:alert] = @to_field.errors.full_messages.to_sentence
      redirect_to edit_project_to_field_path(@project,@to_field)
    end
  end

  private

  def to_fields_params
    params.require(:to_field).permit(:status, :notes)
  end
end
