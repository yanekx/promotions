# frozen_string_literal: true

RSpec.describe Promotions do
  it "has a version number" do
    expect(Promotions::VERSION).not_to be nil
  end

  context 'with sample promotions' do 
    let(:declared_promotions) do
      class MyPromotions < Promotions
        item do 
          product_code Promotions::String
          name Promotions::String
          price Promotions::Money
        end

        # money.rb currency
        currency do 
          iso_code  "USD",
          iso_numeric  "840",
          name "United States Dollar",
          symbol "$",
          subunit "Cent",
          subunit_to_unit 100,
          decimal_mark ".",
          thousands_separator ","
        end

        rules do 
          items.price.sum.gte 60.pounds do
            items.price.sum * 0.9
          end

          product_code.eq('002').& item.count.eq(2) do
            item.price = 8.50
          end
        end
      end
    end

    let(:example_checkout) do 
      class Checkout
        def initialize(promotional_rules)
          @promotional_rules = promotional_rules

          @promotional_rules.register_items([
            { product_code: '001', name: 'Red Wine', price: '9.25' },
            { product_code: '001', name: 'Large Wheelie Bag', price: '45.00' },
            { product_code: '001', name: 'Tracksuit Bottoms', price: '19.95' }
          ])
        end

        def scan(item)
          @promotional_rules.add_item(by_code: item)
        end

        def total
          @promotional_rules.total.in_text
        end
      end
    end

    it 'Basket: 001,002,003' do
      co = Checkout.new(MyPromotions.new)
      co.scan('001')
      co.scan('002')
      co.scan('003')

      expect(co.total).to eq('£66.78')
    end

    it 'Basket: 001,003,001' do
      co = Checkout.new(MyPromotions.new)
      co.scan('001')
      co.scan('002')
      co.scan('003')

      expect(co.total).to eq('£36.95')
    end

    it 'Basket: 001,002,001,003' do
      co = Checkout.new(MyPromotions.new)
      co.scan('001')
      co.scan('002')
      co.scan('001')
      co.scan('003')

      expect(co.total).to eq('£73.76')
    end
  end
end
