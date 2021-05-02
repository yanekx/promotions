# Promotions

A small promotions library for your own small marketplace app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'promotions'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install promotions
```

## Usage

A small example:

1. Let's assume our client is an online marketplace, here is a sample of some of the products available on our site:

   | Product code | Name                    | Price          |
   | ------------- |:----------------------:| --------------:|
   | 001           | Red Wine               | £9.25          |
   | 002           | Large Wheelie Bag      | £45.00         |
   | 003           | Tracksuit Bottoms      | £19.95         |

   1. Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

   2. If you spend over £60, then you get 10% of your purchase
   3. If you buy 2 or more Red Wine then the price drops to £8.50.
   4. Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

2. To implement these rules you need to use such an intefarface:

   ```ruby
        # my_promotion.rb
        require 'promotions'

        class MyPromotions < Promotion
          item do 
            product_code Promotions::String
            name Promotions::String
            price Promotions::Money
          end

          # money.rb currency
          currency do 
            iso_code  "GBP"
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

            product_code.eq('002').& item.count.eq(2) do
              item.price = 8.50
            end
          end
        end
    ```

    Then in your `Checkout` class:

    ```ruby
        class Checkout
          def initialize(promotional_rules)
            #...
            @promotional_rules = promotional_rules

            @promotional_rules.register_items([
              { product_code: '001', name: 'Red Wine', price: '9.25' },
              { product_code: '001', name: 'Large Wheelie Bag', price: '45.00' },
              { product_code: '001', name: 'Tracksuit Bottoms', price: '19.95' }
            ])
            #...
          end

          def scan(item)
            #...
            @promotional_rules.add_item(by_code: item)
            #...
          end

          def total
            #...
            @promotional_rules.total.in_text
            #...
          end
        end
    ```

3. The interface to our checkout looks like this (shown in Ruby):

    ```ruby
    co = Checkout.new(MyPromotions.new)
    co.scan(item)
    co.scan(item)
    price = co.total
    ```

4. Your checkout system will work like this.

   Basket: 001,002,003

   Total price expected: £66.78

   Basket: 001,003,001

   Total price expected: £36.95

   Basket: 001,002,001,003

   Total price expected: £73.76

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yanekx/promotions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/yanekx/promotions/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Promotions project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yanekx/promotions/blob/master/CODE_OF_CONDUCT.md).
