class ApplicationMailer < ActionMailer::Base
  # Overriding Rails default mailer path by creating a mailers folder
  default template_path: -> { "mailers/#{self.class.name.underscore}" }

  default from: 'no-reply@mini-keyz.com'
  layout 'mailer'
end
