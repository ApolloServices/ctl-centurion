class InstrumentsController < ApplicationController
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]

  # GET /instruments
  # GET /instruments.json
  def index
    @instruments = current_user.company.instruments
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = current_user.company.instruments.new
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = current_user.company.instruments.new(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.json { render @instrument }
        format.html { redirect_to @instrument, notice: 'Instrument was successfully created.' }
      else
        format.html { redirect_to new_instrument_path, alert: @instrument.errors.full_messages.to_sentence }
        format.json { render errors: @instrument.errors.full_messages }
      end
    end
  end

  # PATCH/PUT /instruments/1
  # PATCH/PUT /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: 'Instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html {redirect_to edit_instrument_path(@instrument), alert: @instrument.errors.full_messages.to_sentence }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @instrument.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: 'Instrument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def show_file
  #   file = FileAttachment.find_by_id(params[:id])
  #   send_data(Base64.decode64(file.data), :type => file.mime_type, :filename => "#{file.filename}", :disposition => "inline")
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instrument_params
      params.require(:instrument).permit(:name, :company_id, :two_digit_id, :instrument_type, :serial_number, :firmware_version, :service_due_date, actual_service_history_files: [], base_line_history_files: [])
    end
end
