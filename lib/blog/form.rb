module Blog
  class Form
    UNDEFINED = Object.new.freeze

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.to_h
      @messages =
        if attributes.respond_to?(:messages)
          attributes.messages
        else
          {}
        end
    end

    def value(key)
      @attributes[key]
    end
    alias_method :[], :value

    def messages(key = UNDEFINED)
      if key == UNDEFINED
        @messages
      else
        @messages.fetch(key) { [] }
      end
    end

    def messages?(key = UNDEFINED)
      if key == UNDEFINED
        @messages.any?
      else
        @messages.key?(key)
      end
    end
  end
end
