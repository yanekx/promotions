# frozen_string_literal: true

require_relative "declaration/item"
require_relative "declaration/currency"

module Promotions
  class Declaration
    def self.item(&block)
      @item = Item.create_item(block)
    end

    def self.currency(&block)
      @currency = Currency.create_currency(block)
    end
  end
end
