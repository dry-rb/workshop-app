require "types"

module Blog
  module Entities
    class Article < Dry::Struct
      attribute :title, Types::Strict::String
      attribute :status, Types::ArticleStatus
      attribute :published_at, Types::Strict::Time.optional
    end
  end
end
