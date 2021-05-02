# frozen_string_literal: true

require "byebug"

module Promotions
  class Declaration
    class Currency
      STRING_KEYS = %i[
        iso_numeric
        iso_code
        name
        symbol
        decimal_mark
        thousands_separator
      ].freeze

      attr_reader :currency_config

      def initialize
        @currency_config = {}
      end

      def self.create_currency(block)
        new.tap { |currency| currency.instance_eval(&block) }
      end

      def method_missing(method_name, *args, &block)
        parse_config_value(method_name, args.first)
      rescue NoMatchingPatternError
        super
      end

      private

      def parse_config_value(method_name, method_value)
        case [method_name, method_value]
        in Symbol => name, Integer => value
          parse_integer_value(name, value)
        in Symbol => name, String => value
          parse_string_value(name, value)
        end
      end

      def parse_integer_value(name, value)
        case[name, value]
        in :priority, value
          @currency_config[:priority] = value
        in :subunit_to_unit, value
          @currency_config[:priority] = value
        end
      end

      def parse_string_value(name, value)
        @currency_config[name] = value if STRING_KEYS.include?(name)
      end
    end
  end
end
