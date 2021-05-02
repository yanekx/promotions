# frozen_string_literal: true

require_relative "fakes/promotions_fake"
require_relative "fakes/checkout_fake"

RSpec.describe Promotions do
  it "has a version number" do
    expect(Promotions::VERSION).not_to be nil
  end

  context "with sample promotions" do
    subject(:checkout) { CheckoutFake.new(PromotionsFake.new) }

    it "Basket: 001,002,003" do
      scan_multiple(checkout: checkout, codes: %w[001 002 003])

      expect(checkout.total).to eq("£66.78")
    end

    it "Basket: 001,003,001" do
      scan_multiple(checkout: checkout, codes: %w[001 002 003])

      expect(checkout.total).to eq("£36.95")
    end

    it "Basket: 001,002,001,003" do
      scan_multiple(checkout: checkout, codes: %w[001 002 001 003])

      expect(checkout.total).to eq("£73.76")
    end
  end
end
