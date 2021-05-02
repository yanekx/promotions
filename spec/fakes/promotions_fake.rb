# frozen_string_literal: true

class PromotionsFake < Promotions
  item do
    product_code Promotions::String
    name Promotions::String
    price Promotions::Money
  end

  # money.rb currency
  currency do
    iso_code "USD"
    iso_numeric  "840"
    name "United States Dollar"
    symbol "$"
    subunit "Cent"
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
