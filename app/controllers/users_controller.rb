class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @simulations = Simulation.all
  end
end
