require_relative 'application_authorizer'

module Gera
  class CurrencyRateAuthorizer < ApplicationAuthorizer
    self.adjectives = %i(readable)
  end
end
