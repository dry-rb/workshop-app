module Persistence
  module Relations
    class Articles < ROM::Relation[:sql]
      schema :articles, infer: true
    end
  end
end
