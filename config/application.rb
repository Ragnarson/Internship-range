require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InternshipRange
  class Application < Rails::Application
    I18n.available_locales = [:en, :pl]
    I18n.enforce_available_locales = false
  end
end
