class SimulationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show new create update]
  before_action :set_simulation, only: %i[show update destroy send_simulation_mail]

  def index
    @simulations = current_user.simulations
  end

  def show; end

  def new
    Rails.cache.fetch(session.id) { Hash.new }
    redirect_to build_simulation_path(Simulation.form_steps.keys.first)
  end

  def edit; end

  def create
    @simulation = Simulation.new(simulation_params)

    respond_to do |format|
      if @simulation.save
        format.html { redirect_to @simulation, notice: "Simulation was successfully created." }
        format.json { render :show, status: :created, location: @simulation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @simulation.update(simulation_params)
        format.html { redirect_to @simulation, notice: "Simulation was successfully updated." }
        format.json { render :show, status: :ok, location: @simulation }
      else
        format.html { render :edit, status: :unprocessable_entity }       # Thanks Rails team!
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @simulation.destroy
    respond_to do |format|
      format.html { redirect_to simulations_url, notice: "Simulation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def send_simulation_mail
    SimulationMailer.with(user: current_user, simulation: @simulation).send_it_to_me.deliver_later
    flash[:notice] = 'Email envoyé !'
    redirect_to simulation_path(@simulation)
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
        :house_price_bought_amount,
        :house_first_works_amount,
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
        # :fiscal_nb_parts,
        :fiscal_nb_dependent_children,
        :fiscal_nb_alternate_custody_children
      )
  end
end
