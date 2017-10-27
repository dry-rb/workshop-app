require "dry/validation"
require "types"

module Blog
  module Admin
    module Articles
      FormSchema = Dry::Validation.Form do
      end
    end
  end
end
