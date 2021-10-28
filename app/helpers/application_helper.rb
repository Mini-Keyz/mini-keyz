module ApplicationHelper
  AVAILABLE_LANGUAGES = [{ locale: 'fr', name: 'Français' }, { locale: 'en', name: 'English' }].freeze

  def available_languages
    AVAILABLE_LANGUAGES
  end
end
