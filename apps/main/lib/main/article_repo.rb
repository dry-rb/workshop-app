require "blog/repository"

module Main
  class ArticleRepo < Blog::Repository[:articles]
    def listing
      articles.published.ordered_by_published_at
    end

    def by_pk(id)
      articles.published.by_pk(id).one!
    end
  end
end
