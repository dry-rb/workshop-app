require "blog/admin/import"
require "blog/admin/view/controller"

module Blog
  module Admin
    module Views
      module Articles
        class Index < Admin::View::Controller
          configure do |config|
            config.template = "articles/index"
          end

          include Import["article_repo"]

          expose :articles do
            article_repo.listing
          end
        end
      end
    end
  end
end
