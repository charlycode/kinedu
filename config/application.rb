require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :'es-MX'
    config.i18n.fallbacks = [:'es-MX']
    I18n.enforce_available_locales = true
    config.time_zone = 'Monterrey'
    config.active_record.default_timezone = :local
    config.assets.compile = true

    config.logger = Logger.new(STDOUT)
    config.log_level = :debug
  end
end
