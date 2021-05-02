require_relative 'types/money'
require_relative 'types/string'

module Promotions
   module Types
    TYPES = [Promotions::Types::String, Promotions::Types::Money].freeze

    def self.check_type(name)
      TYPES.include?(const_get(name))
    end
  end
end