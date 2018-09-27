require_relative 'application_controller'
module Gera
  class PaymentSystemsController < ApplicationController
    authorize_actions_for PaymentSystem

    EDIT_COLUMNS = %i(
      name system_type currency
      payment_service_name
    )

    SHOW_COLUMNS = %i(
      id img name currency
      accepted_issuing_banks
      is_issuing_bank
      outcome_account_format available_outcome_card_brands
      system_type
      minimal_income_amount maximal_income_amount
      internal_transfer commission priority sort is_visible show_notice auto_set_card income_enabled outcome_enabled referal_output_enabled
      require_unique_income
      manual_confirmation_available require_income_card_verification
      income_fee
      faq_link direct_payment_url cheque_format
      form_fields
      priority_in priority_out
      bestchange_id letter_cod bestchange_key
      payment_service_name
      income_wallets_selection
      content_path_slug
      actions
    )

    def index
      render locals: {
        payment_systems: PaymentSystem.order(:id),
        columns: SHOW_COLUMNS
      }
    end

    def show
      render locals: {
        payment_system: PaymentSystem.find(params[:id]),
        columns: SHOW_COLUMNS
      }
    end

    def new
      render locals: {
        payment_system: PaymentSystem.new,
        columns: EDIT_COLUMNS
      }
    end

    def create
      PaymentSystem.create! permitter_params
    rescue ActiveRecord::RecordInvalid => e
      render :new, locals: {
        payment_system: e.record,
        columns: EDIT_COLUMNS
      }
    end

    def edit
      render locals: {
        payment_system: PaymentSystem.find(params[:id]),
        columns: EDIT_COLUMNS
      }
    end

    def update
      respond_to do |format|
        if payment_system.update_attributes permitter_params
          format.html { redirect_to(payment_systems_path, :notice => 'Status was successfully updated.') }
          format.json { respond_with_bip(payment_system) }
        else
          format.html { render :action => "edit", locals: { payment_system: payment_system, columns: EDIT_COLUMNS } }
          format.json { respond_with_bip(payment_system) }
        end
      end
    end

    private

    def payment_system
      @payment_system ||= PaymentSystem.find params[:id]
    end

    def permitter_params
      params[:payment_system].permit!
    end
  end
end
