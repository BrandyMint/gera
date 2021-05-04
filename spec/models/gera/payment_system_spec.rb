# frozen_string_literal: true

require 'spec_helper'

module Gera
  RSpec.describe PaymentSystem do
    before do
      allow(DirectionsRatesWorker).to receive(:perform_async)
    end
    subject { create :gera_payment_system }
    it { expect(subject).to be_persisted }

    context '#currency=' do
      let(:payment_system) { create :gera_payment_system }

      let(:usd) { Money::Currency.find :usd }
      it 'receive Money::Currency' do
        payment_system.update currency: usd
        expect(payment_system.currency).to eq usd
      end

      it 'receive iso_code' do
        payment_system.update currency: usd.iso_code
        expect(payment_system.currency).to eq usd
      end
    end
  end
end
