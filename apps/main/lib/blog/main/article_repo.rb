require "blog/repository"

module Blog
  module Main
    class ArticleRepo < Blog::Repository[:articles]
    end
  end
end
