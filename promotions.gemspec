# frozen_string_literal: true

require_relative "lib/promotions/version"

Gem::Specification.new do |spec|
  spec.name          = "promotions"
  spec.version       = Promotions::VERSION
  spec.authors       = ["Yan Matveichuk"]
  spec.email         = ["yan.summer23@gmail.com"]

  spec.summary       = "A small promotions library for your own small marketplace app."
  spec.homepage      = "https://github.com/yanekx/promotions"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yanekx/promotions"
  spec.metadata["changelog_uri"] = "https://github.com/yanekx/promotions/blob/main/CHANGELOG.md"

  spec.require_paths = ["lib"]

  # Money gem to handle currencies
  spec.add_dependency "money", "~> 6.7", ">= 6.7.1"

  # For convinient debugging
  spec.add_development_dependency 'byebug', '~> 11.1', '>= 11.1.3'
end
