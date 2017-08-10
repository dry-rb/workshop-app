require "blog/operation"
require "admin/import"
require "admin/articles/form_schema"

module Admin
  module Articles
    class Update < Blog::Operation
      include Admin::Import["article_repo"]

      def call(article_id, attrs)
        article = article_repo.by_pk(article_id)
        validation = FormSchema.(attrs)

        if validation.success?
          article = article_repo.update(article.id, validation.to_h)
          Right(article)
        else
          Left(validation)
        end
      end
    end
  end
end
