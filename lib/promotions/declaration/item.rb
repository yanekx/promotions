# frozen_string_literal: true

require_relative "../types"

module Promotions
  class Declaration
    class Item
      def self.create_item(block)
        new.tap { |item| item.instance_eval(&block) }
      end

      def self.const_missing(name)
        return Promotions::Types.const_get(name) if Promotions::Types.check_type(name)

        super
      end

      def method_missing(method_name, *args, &block)
        instance_variable_set(:@type, args.first)

        define_singleton_method(method_name) { self }
      rescue NameError
        super
      end
    end
  end
end
