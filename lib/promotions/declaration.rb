require_relative 'declaration/item'

module Promotions
  class Declaration
    def self.item(&block)
      @item = Item::create_item(block)
    end

    def self.currency(&block)
      @currency = Currency::create_currency(block)
    end
  end
end