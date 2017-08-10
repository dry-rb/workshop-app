require "admin/import"
require "admin/view/controller"

module Admin
  module Views
    module Articles
      class Edit < Admin::View::Controller
        include Admin::Import["article_repo", "author_repo"]

        configure do |config|
          config.template = "articles/edit"
        end

        expose :article do |input|
          article_repo.by_pk(input.fetch(:id))
        end

        expose :authors do
          author_repo.listing
        end

        expose :validation do |input|
          input.fetch(:validation, {})
        end
      end
    end
  end
end
