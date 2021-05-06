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
    items.price.sum.greater.or.equal(60).pounds do
      items.price.sum.multiply(0.9)
    end

    product_code.eq("002").& items.count.eq(2) do
      item.price.assign(8.50).pounds
    end
  end
end
