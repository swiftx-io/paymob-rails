# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::PaymentTypes::Onetime do
  describe '#initialize_order' do
    context 'when request a new payment with type onetime' do
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

      it 'return payment key' do
        VCR.use_cassette('payment_creation') do
          payment.initialize_order(payment_params)
          uri = URI.parse(payment.payment_link)
          query_params = URI.decode_www_form(uri.query).to_h
          expect(query_params['payment_token']).to be_present
        end
      end
    end
  end
end
