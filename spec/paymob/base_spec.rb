# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::Base do
  describe '#new' do
    context 'when initialize object with wrong billing data args' do
      let(:payment) do
        described_class.new
      end

      let(:invalid_payment_params) do
        { amount: 100, billing_data: {
          email: 'test@example.com',
          last_name: 'account',
          phone_number: '01111111111'
        }, payment_reference: Random.hex(4) }
      end

      it 'raises error' do
        VCR.use_cassette('payment_creation') do
          expect do
            payment.initialize_order(invalid_payment_params)
          end.to raise_error(Paymob::Errors::PaymentArgumentsMissing)
        end
      end
    end
  end

  describe '#initialize_order' do
    context 'when request a new payment with type' do
      let(:payment) do
        described_class.new
      end
      let(:payment_params) do
        { amount: 100, billing_data: {
          email: 'test@example.com',
          first_name: 'test',
          last_name: 'account',
          phone_number: '01111111111'
        }, payment_reference: Random.hex(4) }
      end

      before do
        expect(payment).to receive(:integration_id).and_return('1234')
      end

      it 'return payment key' do
        VCR.use_cassette('payment_creation') do
          payment_token = payment.initialize_order(payment_params)
          expect(payment_token).to be_present
        end
      end
    end
  end
end
