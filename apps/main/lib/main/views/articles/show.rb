require "main/import"
require "main/view/controller"

module Main
  module Views
    module Articles
      class Show < Main::View::Controller
        include Main::Import["article_repo"]

        configure do |config|
          config.template = "articles/show"
        end

        expose :article do |input|
          article_repo.by_pk(input.fetch(:id))
        end
      end
    end
  end
end
