class SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[show update destroy]

  def index
    @simulations = current_user.simulations
  end

  def show; end

  def update
    @simulation.attributes = simulation_params

    if @simulation.save
      redirect_to simulation_path(@simulation)
    else
      render :show
    end
  end

  def new
    @simulation = Simulation.new
  end

  def create
    @simulation = Simulation.new(simulation_params)
    @simulation.user = current_user if current_user

    if @simulation.save
      redirect_to simulation_path(@simulation)
    else
      render :new
    end
  end

  def destroy
    @simulation.destroy

    redirect_to simulations_path
  end

  private

  def set_simulation
    @simulation = Simulation.find(params[:id])
  end

  def simulation_params
    params
      .require(:simulation)
      .permit(
        :house_city,
        :house_price_bought,
        :house_first_works,
        :house_total_charges_amount_per_year,
        :house_property_tax_amount_per_year,
        :house_rent_amount_per_month,
        :house_property_management_cost_percentage,
        :credit_loan_amount,
        :credit_loan_duration,
        :fiscal_status,
        :fiscal_status_duration,
        :fiscal_regimen,
        :fiscal_revenues_p1,
        :fiscal_revenues_p2,
        :fiscal_nb_parts
      )
  end
end
