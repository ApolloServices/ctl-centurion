class NotesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @notes = @project.notes
  end

  def new
    @project = Project.find(params[:project_id])
    @note = @project.notes.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])
  end

  def show
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = 'Note is successfully updated'
      redirect_to project_notes_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      redirect_to edit_project_note_path(@project)
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @note = @project.notes.new(note_params)
    if @note.save
      flash[:notice] = 'Note is successfully saved'
      redirect_to project_notes_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      redirect_to new_project_note_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = 'Note is successfully deleted'
    else
      flash[:notice] = 'Something is wrong'
    end
    redirect_to project_notes_path(@project)
  end

  def note_params
    params.require(:note).permit(:item,:project_id, :instructions, :index)
  end
end
