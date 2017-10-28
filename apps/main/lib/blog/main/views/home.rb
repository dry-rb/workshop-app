require "blog/main/import"
require "blog/main/view/controller"

module Blog
  module Main
    module Views
      class Home < Main::View::Controller
        configure do |config|
          config.template = "home"
        end

        include Import["article_repo"]

        expose :articles do
          article_repo.listing
        end
      end
    end
  end
end
