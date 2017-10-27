# auto_register: false

require "slim"
require "dry/view/controller"
require "blog/admin/container"

module Blog
  module Admin
    module View
      class Controller < Dry::View::Controller
        configure do |config|
          config.paths = [Container.root.join("web/templates")]
          config.context = Container["view.context"]
          config.layout = "application"
        end
      end
    end
  end
end
