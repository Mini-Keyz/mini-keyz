source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # The RSpec testing framework
  gem 'rspec-rails'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Livereload in the browser
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload', '~> 0.3.17'

  # SMTP server
  gem 'mailcatcher'
end

group :test do
  # Keeps our Ruby on Rails project's test database clean between test runs
  gem 'database_cleaner-active_record'

  # Facilitates tests
  gem 'shoulda-matchers', '~> 4.0'
end

# Stores ENV variables
gem 'figaro'

# I18n translations
gem 'rails-i18n'

# Wizard form
gem 'wicked'

# Speeding things up with SPA-like functionalities
gem 'turbo-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Log in system
gem 'devise', '~> 4.7'

# Time difference
gem 'time_difference', '~> 0.5.0'

# My super gemmm that I made and publish on rubygems.org
gem 'french_tax_system', '~> 1.0.1'

# Needed for Ruby v3
gem 'rexml'
