class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @simulations = Simulation.all
  end
end
