require "blog/admin/import"
require "blog/admin/view/controller"
require "blog/form"

module Blog
  module Admin
    module Views
      module Articles
        class New < Admin::View::Controller
          configure do |config|
            config.template = "articles/new"
          end

          include Import["article_repo"]

          expose :form do |validation: {}|
            Blog::Form.new(validation)
          end

          expose :author_options { article_repo.author_options }
          expose :status_options { Types::ArticleStatus.values }
        end
      end
    end
  end
end
