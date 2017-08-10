require "dry-validation"
require "types"

module Admin
  module Articles
    FormSchema = Dry::Validation.Form do
      required(:title).filled
      required(:author_id).filled(:int?)
      required(:status).filled(included_in?: Types::ArticleStatus.values)
      required(:published_at).maybe(:time?)

      rule(published_at: [:status, :published_at]) do |status, published_at|
        status.eql?("published") > published_at.filled?
      end
    end
  end
end
