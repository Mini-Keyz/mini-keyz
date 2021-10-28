class PagesController < ApplicationController
  skip_before_action :authenticate_user!,
                     only: %i[home about contact accept_cookies refuse_cookies cookies_policy change_locale]

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

  def change_locale
    locale = params[:locale]

    # Set preferred language for next sessions
    set_preferred_language(locale)

    # Redirect to current page
    redirect_back(locale: locale, fallback_location: root_path)
  end

  def set_preferred_language(locale)
    cookies[:preferred_language] = locale
  end
end
