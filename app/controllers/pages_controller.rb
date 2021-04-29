class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about contact]
  def about; end

  def contact; end

  def home; end
end
