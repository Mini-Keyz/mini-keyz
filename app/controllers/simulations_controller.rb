class SimulationsController < ApplicationController

  def new
    @simulation = Simulation.new
  end

  def create
    @simulation = Simulation.new(simulation_params)
    @simulation.user = current_user if current_user

    if @simulation.after_save
      redirect_to simulation_path(@simulation)
    else
      render :new
    end
  end

  private

  def simulation_params
    params
      .require(:simulation)
      .permit(
        :house_city,
        :house_price_bought,
        :house_first_works,
        :house_annual_charges,
        :house_property_tax,
        :house_rent_per_month,
        :house_delegated_maintenance,
        :credit_amount,
        :credit_duration,
        :fiscal_status,
        :fiscal_status_duration,
        :fiscal_regimen,
        :fiscal_revenues_p1,
        :fiscal_revenues_p2,
        :fiscal_nb_parts
      )
  end
end
