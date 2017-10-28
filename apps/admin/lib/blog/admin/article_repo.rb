require "blog/repository"

module Blog
  module Admin
    class ArticleRepo < Blog::Repository[:articles]
    end
  end
end
