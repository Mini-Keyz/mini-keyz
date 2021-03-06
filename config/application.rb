require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MiniKeyz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Application exceptions configuration, here Rails uses routes to handle it rather than prebuilt html files in public
    config.exceptions_app = routes

    # I18n configuration
    config.i18n.default_locale = :fr
    config.i18n.available_locales = %i[en fr]

    # Rails will look in our nested dictionnaries folder
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Subdomain configuration
    config.action_dispatch.tld_length = Integer(ENV['TLD_LENGTH'] || 1)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
