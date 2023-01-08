require 'dav4rack'

class TasksController < ApplicationController
  before_action :set_project, except: [:tasks, :new_task]
  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.new
  end

  # this is the action called on global TASKS menu in new bar
  def new_task
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'Task has been successfully updated'
      if params[:redirect_to].present?
        redirect_to tasks_path
      else
        redirect_to project_tasks_path(@project)
      end
    else
      flash[:alert] = 'Something is wrong'
      redirect_to edit_project_task_path(@project,id: @task.id)
    end
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = 'Task has been successfully saved'
      redirect_to project_tasks_path(@project)
    else
      flash[:alert] = 'Something is wrong'
      redirect_to new_project_task_path(@project)
    end
  end

  # this is the action called on global TASKS menu in new bar
  def create_task
    @project = Project.find_by_id(params[:task][:project_id])
    if @project.blank?
      flash[:alert] = 'Project must be present'
      redirect_to tasks_path
    end
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = 'Task has been successfully saved'
      redirect_to tasks_path
    else
      flash[:alert] = 'Something is wrong'
      redirect_to new_task_path
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = 'Task has been successfully deleted'
    else
      flash[:alert] = 'Something is wrong'
    end
    if params[:redirect_to].present?
      redirect_to tasks_path
    else
      redirect_to project_tasks_path(@project)
    end
  end

  # this is the action for global TASKS menu in new bar
  def tasks
    @tasks = current_user.company.projects.includes(:tasks).map(&:tasks).reject(&:blank?).flatten
  end

  private

  def set_project
    @project = Project.find_by_id(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:due_date, :surveyor_id, :description, :completed_date, :project_id, :notes)
  end
end
