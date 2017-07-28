require "blog/repository"

module Main
  class ArticleRepo < Blog::Repository[:articles]
  end
end
