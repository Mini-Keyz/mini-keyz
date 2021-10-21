class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about contact accept_cookies refuse_cookies cookies_policy]
  def about; end

  def contact; end

  def home; end

  def accept_cookies
    cookies[:cookies_acceptance] = true
  end

  def refuse_cookies
    cookies[:cookies_acceptance] = false
  end

  def cookies_policy; end
end
