class SurveyTypesController < ApplicationController
  before_action :set_survey_type, only: [:show, :edit, :update, :destroy]
  before_action :reject_empty_stylesheet, only: [:create, :update]

  # GET /survey_types
  # GET /survey_types.json
  def index
    @survey_types = current_user.company.survey_types
  end

  # GET /survey_types/1
  # GET /survey_types/1.json
  def show
    @optional_stylesheets = current_user.company.stylesheets.optional_stylesheets
  end

  # GET /survey_types/new
  def new
    @survey_type = current_user.company.survey_types.new
    @optional_stylesheets = current_user.company.stylesheets.optional_stylesheets
  end

  # GET /survey_types/1/edit
  def edit
    @optional_stylesheets = current_user.company.stylesheets.optional_stylesheets
  end

  # POST /survey_types
  # POST /survey_types.json
  def create
    @survey_type = current_user.company.survey_types.new(survey_type_params)

    if params[:survey_type][:optional_stylesheets]
      optional_stylesheets = Stylesheet.find(params[:survey_type][:optional_stylesheets].map {|x| x.to_i})
      @survey_type.optional_stylesheets = optional_stylesheets
    end
    respond_to do |format|
      if @survey_type.save
        format.html { redirect_to @survey_type, notice: 'Survey Type was successfully created.' }
        format.json { render :show, status: :created, location: @survey_type }
      else
        format.html { redirect_to new_survey_type_path, alert: @survey_type.errors.full_messages.uniq.join(', ') }
        format.json { render json: @survey_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_types/1
  # PATCH/PUT /survey_types/1.json
  def update
    respond_to do |format|

      if params[:survey_type].nil?
        flash[:alert] = 'You submitted nothing.'
        redirect_to @survey_type
        return
      end

      if @survey_type.update(survey_type_params)
        if params[:survey_type][:optional_stylesheets]
          optional_stylesheets = Stylesheet.find(params[:survey_type][:optional_stylesheets].map {|x| x.to_i})
          @survey_type.optional_stylesheets = optional_stylesheets
        end

        if @survey_type.save
          format.html { redirect_to @survey_type, notice: 'Survey Type was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey_type }
        else
          format.html { render :edit }
          format.json { render json: @survey_type.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @survey_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_types/1
  # DELETE /survey_types/1.json
  def destroy
    @survey_type.destroy
    respond_to do |format|
      format.html { redirect_to survey_types_url, notice: 'Survey Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_type
      @survey_type = SurveyType.find(params[:id])
    end

    # bootstrap-multiselect is used to choose style sheet, and it send an empty value string i.e. "" among the selected values
    # so this method basically remove that empty value
    def reject_empty_stylesheet
      params[:survey_type][:default_stylesheets].reject!(&:blank?) if params[:survey_type] && params[:survey_type][:default_stylesheets]
      params[:survey_type][:optional_stylesheets].reject!(&:blank?) if params[:survey_type] && params[:survey_type][:optional_stylesheets]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_type_params
      params.require(:survey_type).permit(:two_digit_id, :description, :company_id)
    end
end
