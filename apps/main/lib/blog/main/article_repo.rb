require "blog/repository"

module Blog
  module Main
    class ArticleRepo < Blog::Repository[:articles]
      def by_id(id)
        articles.by_pk(id).one!
      end

      def listing(limit = 10)
        articles.ordered_by_created_at.limit(limit)
      end

      private

      def articles
        super.published
      end
    end
  end
end
