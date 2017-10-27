require "blog/main/view/controller"

module Blog
  module Main
    module Views
      class Welcome < View::Controller
        configure do |config|
          config.template = "welcome"
        end
      end
    end
  end
end
