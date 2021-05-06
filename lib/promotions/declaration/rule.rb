# frozen_string_literal: true

require_relative "../types"
require "byebug"

module Promotions
  class Declaration
    class Rule
      attr_reader :calls

      def initialize
        @calls = []
      end

      def self.create_rule(block) = new.tap { |item| item.instance_eval(&block) }

      def method_missing(method_name, *args, &block)
        parse_call([method_name, args.first, block])
        self
      rescue NoMatchingPatternError
        super
      end

      private

      def parse_call(call_context)
        case call_context
        in Symbol => method_name, argument, nil
          parse_noblock([method_name, argument])
        in Symbol => method_name, argument, Proc => block
          parse_block([method_name, argument], block: block)
        end
      end

      def parse_block(call_context, block: nil)
        parse_noblock(call_context)
        instance_eval(&block)
      end

      def parse_noblock(call_context)
        case call_context
          in Symbol => method_name, nil                 then @calls << method_name
          in Symbol => method_name, Integer => argument then @calls << { name: method_name, argument: argument, argument_type: Integer }
          in Symbol => method_name, String  => argument then @calls << { name: method_name, argument: argument, argument_type: String }
          in Symbol => method_name, Float   => argument then @calls << { name: method_name, argument: argument, argument_type: Float }
          in Symbol => method_name, Rule    => argument then @calls << { name: method_name, argument_type: Rule }; argument.send(method_name)
        end
      end
    end
  end
end
