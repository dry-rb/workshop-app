module Persistence
  module Relations
    class Articles < ROM::Relation[:sql]
      schema :articles, infer: true do
        associations do
          belongs_to :author
        end
      end

      def ordered_by_created_at
        order(self[:created_at].desc)
      end
    end
  end
end
