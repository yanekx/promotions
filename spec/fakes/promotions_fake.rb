# frozen_string_literal: true

class PromotionsFake < Promotions::Declaration
  item do
    product_code Item::String
    name Item::String
    price Item::Money
  end

  # money.rb currency
  currency do
    iso_code "GBP"
    iso_numeric  "826"
    name "Pound sterling"
    symbol "£"
    subunit "Penny"
    subunit_to_unit 100
    decimal_mark "."
    thousands_separator ","
  end

  rules do
    items.price.sum.gte 60.pounds do
      items.price.sum * 0.9
    end

    product_code.eq("002").& item.count.eq(2) do
      item.price = 8.50
    end
  end
end
