class ItemsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @items = @project.items
  end

  def new
    @project = Project.find(params[:project_id])
    @item = @project.items.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @item = Item.find(params[:id])
  end

  def show
    @project = Project.find(params[:project_id])
    @item = Item.find(params[:id])
    @tasks = @item.tasks
  end

  def update
    @project = Project.find(params[:project_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'Item is successfully updated'
      redirect_to project_items_path(@project)
    else
      flash[:alert] = 'Something is wrong'
      redirect_to edit_project_item_path(@project)
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @item = @project.items.new(item_params)
    if @item.save
      flash[:notice] = 'Item is successfully saved'
      redirect_to project_items_path(@project)
    else
      flash[:alert] = @item.errors.full_messages.to_sentence
      redirect_to new_project_item_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = 'Item is successfully deleted'
    else
      flash[:alert] = 'Something is wrong'
    end
    redirect_to project_items_path(@project)
  end

  private
  def item_params
    params.require(:item).permit(:item_name,:project_id, :details)
  end
end
