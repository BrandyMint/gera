# frozen_string_literal: true

require_relative 'application_controller'

module Gera
  class ExchangeRatesController < ApplicationController
    authorize_actions_for ExchangeRate

    DEFAULT_FILTER = 'all'
    FILTERS = %w[all banks_only payment_systems_only coins_only].freeze

    helper_method :current_filter, :filtered_payment_systems

    def index
      respond_to do |format|
        format.html { redirect_to exchange_rate_path(default_exchange_rate) }
      end
    end

    def update
      respond_to do |format|
        if exchange_rate.update permitted_params
          format.html { redirect_to(exchange_rate, notice: 'Status was successfully updated.') }
          format.json { respond_with_bip(exchange_rate) }
        else
          format.html { render action: 'edit' }
          format.json { respond_with_bip(exchange_rate) }
        end
      end
    end

    def show
      render locals: {
        exchange_rate: exchange_rate
      }
    end

    def details
      render 'direction_details', locals: { direction: exchange_rate.direction }, layout: nil
    end

    private

    def exchange_rate
      @exchange_rate ||= ExchangeRate.find params[:id]
    end

    def permitted_params
      params[:exchange_rate].permit :is_enabled, :commission, :auto_payout_enabled
    end

    def exchange_rates
      ExchangeRate.available
    end

    def default_exchange_rate
      id = session[:last_exchange_rate_id]
      er = exchange_rates.find_by(id: id) if id.present?

      er || exchange_rates.first
    end

    def filtered_payment_systems
      case current_filter
      when 'all'
        payment_systems
      when 'banks_only'
        payment_systems.system_type_bank.ordered.available
      when 'payment_systems_only'
        payment_systems.where(system_type: %i[payment_system cheque]).ordered.available
      when 'coins_only'
        payment_systems.system_type_crypto.ordered.available
      else
        raise "Unknown current_filter #{current_filter}"
      end
    end

    def current_filter
      FILTERS.include?(params[:filter]) ? params[:filter] : DEFAULT_FILTER
    end
  end
end
