require_relative 'application_controller'
module Gera
  class CurrenciesController < ApplicationController
    authorize_actions_for CurrencyRate
  end
end
