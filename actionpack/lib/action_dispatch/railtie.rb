require "action_dispatch"
require "rails"

module ActionDispatch
  class Railtie < Rails::Railtie
    config.action_dispatch = ActiveSupport::OrderedOptions.new
    config.action_dispatch.x_sendfile_header = ""
    config.action_dispatch.ip_spoofing_check = true
    config.action_dispatch.show_exceptions = true
    config.action_dispatch.best_standards_support = true
    config.action_dispatch.tld_length = 1

    # Prepare dispatcher callbacks and run 'prepare' callbacks
    initializer "action_dispatch.prepare_dispatcher" do |app|
      ActionDispatch::Callbacks.to_prepare { app.routes_reloader.execute_if_updated }
    end

    initializer "action_dispatch.configure" do |app|
      ActionDispatch::Http::URL.tld_length = app.config.action_dispatch.tld_length
    end
  end
end
