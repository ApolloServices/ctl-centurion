class StylesheetsController < ApplicationController
  before_action :set_stylesheet, only: [:show, :edit, :update, :destroy]
  after_action :apply_to_survey_types, only: [:create]

  # GET /stylesheets
  # GET /stylesheets.json
  def index
    @stylesheets = current_user.company.stylesheets
  end

  # GET /stylesheets/1
  # GET /stylesheets/1.json
  def show
  end

  # GET /stylesheets/new
  def new
    @stylesheet = Stylesheet.new
  end

  # GET /stylesheets/1/edit
  def edit
  end

  # POST /stylesheets
  # POST /stylesheets.json
  def create
    @stylesheet = Stylesheet.new(stylesheet_params)

    respond_to do |format|
      if @stylesheet.save
        format.html { redirect_to @stylesheet, notice: 'Stylesheet was successfully created.' }
        format.json { render :show, status: :created, location: @stylesheet }
      else
        format.html { render :new }
        format.json { render json: @stylesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stylesheets/1
  # PATCH/PUT /stylesheets/1.json
  def update
    respond_to do |format|
      if @stylesheet.update(stylesheet_params)
        format.html { redirect_to @stylesheet, notice: 'Stylesheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @stylesheet }
      else
        format.html { render :edit }
        format.json { render json: @stylesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stylesheets/1
  # DELETE /stylesheets/1.json
  def destroy
    @stylesheet.destroy
    respond_to do |format|
      format.html { redirect_to stylesheets_url, notice: 'Stylesheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stylesheet
      @stylesheet = Stylesheet.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stylesheet_params
      params.fetch(:stylesheet, {})
      params.require(:stylesheet).permit(:unique_id, :stylesheet_type, :name, :path, :file, :label, :output_extension, :create_slx, :slx_template, :user_id, :company_id)
    end

    def apply_to_survey_types
      if params[:stylesheet][:apply_to_all] == "1" && @stylesheet.stylesheet_type == Stylesheet::STYLESHEET_TYPE_DEFAULT
        # to reduce number of queries for fetching the id, just get it one time and assign to variable
        stylesheet_id = @stylesheet.id
        survey_types = @stylesheet.company.survey_types
        if survey_types.present?
          # use import method to reduce the number of queries to create the following objects.
          default_relations_array = []
          survey_types.each do |survey_type|
            default_relations_array << SurveyTypeDefaultStylesheet.new(survey_type_id: survey_type.id, stylesheet_id: stylesheet_id)
          end
          SurveyTypeDefaultStylesheet.import default_relations_array
        end
      end
    end
end
