require "blog/operation"
require "admin/import"
require "admin/articles/form_schema"

module Admin
  module Articles
    class Create < Blog::Operation
      include Admin::Import["article_repo"]

      def call(attrs)
        validation = FormSchema.(attrs)

        if validation.success?
          article = article_repo.create(validation.to_h)
          Right(article)
        else
          Left(validation)
        end
      end
    end
  end
end
