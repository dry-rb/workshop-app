require "dry/validation"
require "types"

module Blog
  module Admin
    module Articles
      FormSchema = Dry::Validation.Form do
        required(:title).filled
        required(:status).filled(included_in?: Types::ArticleStatus.values)
        required(:published_at).maybe(:time?)
      end
    end
  end
end
