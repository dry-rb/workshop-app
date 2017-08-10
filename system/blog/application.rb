require "dry/web/roda/application"
require_relative "container"

module Blog
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.container = Container
    end

    route do |r|
      r.on "admin" do
        r.run ::Admin::Application.freeze.app
      end

      r.run ::Main::Application.freeze.app
    end

    error do |e|
      self.class[:rack_monitor].instrument(:error, exception: e)
      raise e
    end
  end
end
