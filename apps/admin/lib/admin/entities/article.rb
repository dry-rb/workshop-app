# auto_register: false

module Admin
  module Entities
    class Article < ROM::Struct
      def teaser
        "Great article: #{title}"
      end
    end
  end
end
