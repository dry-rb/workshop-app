module Persistence
  module Relations
    class Articles < ROM::Relation[:sql]
      schema :articles, infer: true do
        associations do
          belongs_to :author
        end
      end

      def published
        by_status("published")
      end

      def ordered_by_created_at
        order(self[:created_at].desc)
      end

      def ordered_by_published_at
        order(self[:published_at].desc)
      end
    end
  end
end
