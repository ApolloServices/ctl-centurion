class SurveyControllersController < ApplicationController
  before_action :set_survey_controller, only: [:show, :edit, :update, :destroy]

  # GET /survey_controllers
  # GET /survey_controllers.json
  def index
    @survey_controllers = current_user.company.survey_controllers
  end

  # GET /survey_controllers/1
  # GET /survey_controllers/1.json
  def show
  end

  # GET /survey_controllers/new
  def new
    @survey_controller = current_user.company.survey_controllers.new
  end

  # GET /survey_controllers/1/edit
  def edit
  end

  # POST /survey_controllers
  # POST /survey_controllers.json
  def create
    @survey_controller = current_user.company.survey_controllers.new(survey_controller_params)

    respond_to do |format|
      if @survey_controller.save
        format.json { render @survey_controller }
        format.html { redirect_to @survey_controller, notice: 'Controller was successfully created.' }
      else
        format.html { redirect_to new_survey_controller_path, alert: @survey_controller.errors.full_messages.to_sentence }
        format.json { render json: @survey_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_controllers/1
  # PATCH/PUT /survey_controllers/1.json
  def update
    respond_to do |format|
      if @survey_controller.update(survey_controller_params)
        format.html { redirect_to @survey_controller, notice: 'Controller was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_controller }
      else
        format.html { redirect_to edit_survey_controller_path(@survey_controller), alert: @survey_controller.errors.full_messages.to_sentence }
        format.json { render json: @survey_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_controllers/1
  # DELETE /survey_controllers/1.json
  def destroy
    @survey_controller.destroy
    respond_to do |format|
      format.html { redirect_to survey_controllers_url, notice: 'Controller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_controller
      @survey_controller = SurveyController.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_controller_params
      params.require(:survey_controller).permit(:name, :user_id, :two_digit_id, :controller_type, :serial_number, :software_version, :controller_login)
    end
end
