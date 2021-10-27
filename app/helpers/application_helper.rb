module ApplicationHelper
  AVAILABLE_LANGUAGES = %w[Français English].freeze

  def available_languages
    AVAILABLE_LANGUAGES
  end
end
