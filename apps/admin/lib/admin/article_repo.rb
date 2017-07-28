require "blog/repository"
require "admin/entities"

module Admin
  class ArticleRepo < Blog::Repository[:articles]
    relations :authors

    commands :create, update: :by_pk

    struct_namespace Entities

    def by_pk(id)
      articles.by_pk(id).one!
    end

    def listing
      articles.ordered_by_created_at
    end

    private

    def articles
      aggregate(:author)
    end
  end
end
