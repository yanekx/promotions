# frozen_string_literal: true

module CheckoutHelper
  def scan_multiple(checkout:, codes:)
    codes.each { |code| checkout.send(code) }
  end
end
