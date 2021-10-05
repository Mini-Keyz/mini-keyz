module StepsControllers
  class SimulationStepsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[show update]

    include Wicked::Wizard

    steps(*Simulation.form_steps.keys)

    def show
      simulation_attrs = Rails.cache.read session.id
      @simulation = Simulation.new simulation_attrs
      render_wizard
    end

    def update
      simulation_attrs = Rails.cache.read(session.id).merge simulation_params
      @simulation = Simulation.new simulation_attrs

      if @simulation.valid?
        Rails.cache.write session.id, simulation_attrs
        redirect_to_next next_step
      else
        render_wizard nil, status: :unprocessable_entity
      end
    end

    private

    # Only allow the params for specific attributes allowed in this step
    def simulation_params
      params.require(:simulation).permit(Simulation.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      simulation_attrs = Rails.cache.fetch(session.id)
      @simulation = Simulation.new simulation_attrs
      @simulation.user = current_user if current_user
      @simulation.save!
      Rails.cache.delete session.id
      simulation_path(@simulation)
    end
  end
end
