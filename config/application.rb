require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ConsentInsights
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.application_name = "Consent Insights"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Pacific Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end

  VERSION = "0.0.1".freeze

  PIXEL_IMG = ['89504e470d0a1a0a0000000d4948445200000001000000010100000000376ef9240000001049444154789c626001000000ffff03000006000557bfabd40000000049454e44ae426082'].pack('H*')
end
