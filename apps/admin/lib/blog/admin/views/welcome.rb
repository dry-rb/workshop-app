require "blog/admin/view/controller"

module Blog
  module Admin
    module Views
      class Welcome < View::Controller
        configure do |config|
          config.template = "welcome"
        end
      end
    end
  end
end
