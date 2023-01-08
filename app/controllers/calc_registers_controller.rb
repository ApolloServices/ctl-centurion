class CalcRegistersController < ApplicationController
  before_action :set_project
  def index
    @calc_registers = @project.calc_registers
  end

  def new
    @calc_register = @project.calc_registers.new
  end

  def edit
    @calc_register = CalcRegister.find(params[:id])
  end

  def show
    @calc_register = CalcRegister.find(params[:id])
  end

  def update
    @calc_register = CalcRegister.find(params[:id])
    if @calc_register.update(register_params)
      flash[:notice] = 'Register is successfully updated'
      redirect_to project_calc_registers_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      render :edit
    end
  end

  def create
    @calc_register = @project.calc_registers.new(register_params)
    if @calc_register.save
      flash[:notice] = 'Register is successfully saved'
      redirect_to project_calc_registers_path(@project)
    else
      flash[:notice] = 'Something is wrong'
      render :new
    end
  end

  def destroy
    @calc_register = CalcRegister.find(params[:id])
    if @calc_register.destroy
      flash[:notice] = 'Register is successfully deleted'
    else
      flash[:notice] = 'Something is wrong'
    end
    redirect_to project_calc_registers_path(@project)
  end

  private

  def set_project
    @project = Project.find_by_id(params[:project_id])
  end

  def register_params
    params.require(:calc_register).permit(:subject, :calculation_record, :status, :surveyor_id, :project_id, :date)
  end
end
