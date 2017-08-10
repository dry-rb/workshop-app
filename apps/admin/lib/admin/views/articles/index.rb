require "admin/import"
require "admin/view/controller"

module Admin
  module Views
    module Articles
      class Index < Admin::View::Controller
        include Admin::Import["article_repo"]

        configure do |config|
          config.template = "articles/index"
        end

        expose :articles do
          article_repo.listing
        end
      end
    end
  end
end
