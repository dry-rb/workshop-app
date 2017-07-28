require "main/import"
require "main/view/controller"

module Main
  module Views
    class Home < Main::View::Controller
      include Main::Import["article_repo"]

      configure do |config|
        config.template = "home"
      end

      expose :articles do
        article_repo.listing
      end
    end
  end
end

