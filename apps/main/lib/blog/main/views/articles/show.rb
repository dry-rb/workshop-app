require "blog/main/import"
require "blog/main/view/controller"

module Blog
  module Main
    module Views
      module Articles
        class Show < Main::View::Controller
          configure do |config|
            config.template = "articles/show"
          end

          include Import["article_repo"]

          expose :article do |id:|
            article_repo.by_id(id)
          end
        end
      end
    end
  end
end
