class SurveyorsController < ApplicationController
  before_action :set_surveyor, only: [:show, :edit, :update, :destroy]

  # GET /surveyors
  # GET /surveyors.json
  def index
    @surveyors = current_user.company.users
  end

  # GET /surveyors/1
  # GET /surveyors/1.json
  def show
  end

  # GET /surveyors/new
  def new
    @surveyor = current_user.company.users.new
  end

  # GET /surveyors/1/edit
  def edit
  end

  # POST /surveyors
  # POST /surveyors.json
  def create
    @surveyor = current_user.company.users.new(surveyor_params)

    respond_to do |format|
      if @surveyor.save
        format.json { render @surveyor }
        format.html { redirect_to surveyor_path(@surveyor.id), notice: 'Surveyor was successfully created.' }
      else
        format.html { redirect_to new_surveyor_path, alert: @surveyor.errors.full_messages.to_sentence }
        format.json { render json: @surveyor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveyors/1
  # PATCH/PUT /surveyors/1.json
  def update
    respond_to do |format|
      if @surveyor.update(surveyor_params)
        format.html { redirect_to surveyor_path(@surveyor.id), notice: 'Surveyor was successfully updated.' }
        format.json { render :show, status: :ok, location: @surveyor }
      else
        format.html { redirect_to edit_surveyor_path(@surveyor), alert: @surveyor.errors.full_messages.to_sentence }
        format.json { render json: @surveyor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveyors/1
  # DELETE /surveyors/1.json
  def destroy
    @surveyor.destroy
    respond_to do |format|
      format.html { redirect_to surveyors_url, notice: 'Surveyor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surveyor
      @surveyor = User.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surveyor_params
      params.require(:user).permit(:name, :company_id, :two_digit_id, :initials, :email, :password)
    end
end
