require "admin/import"
require "admin/view/controller"

module Admin
  module Views
    module Articles
      class New < Admin::View::Controller
        include Admin::Import["author_repo"]

        configure do |config|
          config.template = "articles/new"
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
