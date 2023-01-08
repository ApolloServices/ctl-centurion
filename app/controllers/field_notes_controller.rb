class FieldNotesController < ApplicationController
  before_action :set_project
  def index
    @field_notes = @project.field_notes
  end

  def new
    @field_note = @project.field_notes.new
  end

  def edit
    @field_note = FieldNote.find(params[:id])
  end

  def show
    @field_note = FieldNote.find(params[:id])
  end

  def update
    @field_note = FieldNote.find(params[:id])
    # @field_note.day_job_file = params[:field_note][:job_file] if params[:field_note][:job_file]
    # day_job_file = params[:field_note][:day_job_file]
    # pdf_file = params[:field_note][:pdf_file]
    # if day_job_file
    #   @field_note.upload_file(day_job_file, 'day_job')
    # end
    # if pdf_file
    #   @field_note.upload_file(pdf_file, 'pdf')
    # end
    if @field_note.update(note_params)
      @field_note.update_day_job
      flash[:notice] = 'Field Note is successfully updated'
      redirect_to project_field_notes_path(@project)
    else
      flash[:alert] = 'Something is wrong'
      redirect_to edit_project_field_note_path(project_id: @project.id,id: @field_note.id)
    end
  end

  def create
    @field_note = @project.field_notes.new(note_params)
    # @field_note.day_job_file = params[:field_note][:job_file] if params[:field_note][:job_file]
    if @field_note.save
      # day_job_file = params[:field_note][:day_job_file]
      # @field_note.day_job_file = day_job_file
      # pdf_file = params[:field_note][:pdf_file]
      # if day_job_file
      #   @field_note.upload_file(day_job_file, 'day_job')
      # end
      # if pdf_file
      #   @field_note.upload_file(pdf_file, 'pdf')
      # end
      flash[:notice] = 'Field Note is successfully saved'
      redirect_to project_field_notes_path(@project)
    else
      flash[:alert] = 'Something is wrong'
      redirect_to new_project_field_note_path(@project)
    end
  end

  def destroy
    @field_note = FieldNote.find(params[:id])
    if @field_note.destroy
      flash[:notice] = 'Field Note is successfully deleted'
    else
      flash[:alert] = 'Something is wrong'
    end
    redirect_to project_field_notes_path(@project)
  end

  def show_uploaded_file
    field_note = FieldNote.find(params[:field_note_id])
    if params[:job_file] == "true"
      @file = field_note.day_job_file
    else
      @file = field_note.file_attachments.first
    end
    send_data(Base64.decode64(@file.data), :type => @file.mime_type, :filename => "#{@file.filename}", :disposition => "inline")
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def note_params
    params.require(:field_note).permit(:file_type, :date, :description, :summary, :project_id, :additional_processing, :detail, :file_id, :surveyor_id, :additional_1,:additional_2,:additional_3,:day_job_file,:additional_4, :job_file, :pdf_notes_file, :pdf_file, supporting_documents: [])
  end
end
