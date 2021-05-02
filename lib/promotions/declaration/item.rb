require_relative '../types'

module Promotions
  class Declaration
    class Item
      def self.create_item(block)
        self::new.instance_eval(&block)
      end

      def self.const_missing(name)
        return Promotions::Types.const_get(name) if Promotions::Types.check_type(name)
        super
      end

      def method_missing(method_name, *args)
        type_name = args.first
        instance_variable_set(:@type, type_name)
        
        define_singleton_method(method_name) { self }
      end
    end
  end
end
