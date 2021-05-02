# frozen_string_literal: true

class CheckoutFake
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules

    @promotional_rules.register_items([
                                        { product_code: "001", name: "Red Wine", price: "9.25" },
                                        { product_code: "001", name: "Large Wheelie Bag", price: "45.00" },
                                        { product_code: "001", name: "Tracksuit Bottoms", price: "19.95" }
                                      ])
  end

  def scan(item)
    @promotional_rules.add_item(by_code: item)
  end

  def total
    @promotional_rules.total.in_text
  end
end
