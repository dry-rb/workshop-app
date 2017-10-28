require "blog/admin/import"
require "blog/admin/view/controller"
require "blog/form"

module Blog
  module Admin
    module Views
      module Articles
        class Edit < Admin::View::Controller
          configure do |config|
            config.template = "articles/edit"
          end

          include Import["article_repo"]

          expose :article do |id:|
            article_repo.by_id(id)
          end

          expose :form do |article, validation: nil|
            Blog::Form.new(validation || article)
          end

          expose :author_options { article_repo.author_options }
          expose :status_options { Types::ArticleStatus.values }
        end
      end
    end
  end
end
