module Blog
  module Admin
    class ArticleRepo
      def create(attrs)
        puts "Creating article from #{attrs.inspect}"
        attrs
      end
    end
  end
end
