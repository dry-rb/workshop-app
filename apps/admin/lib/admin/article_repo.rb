require "blog/repository"
require "admin/entities"

module Admin
  class ArticleRepo < Blog::Repository[:articles]
  end
end
