# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::Payment do
  describe '#new' do
    context 'when initialize object with correct args' do
      let(:payment) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4))
      end

      it 'assigns amount' do
        expect(payment.instance_variable_get(:@amount)).to eq(100)
      end

      it 'assigns billing_data' do
        expect(payment.instance_variable_get(:@billing_data)).to be_present
      end

      it 'assigns payment reference' do
        expect(payment.instance_variable_get(:@payment_reference)).to be_present
      end
    end

    context 'when initialize object with wrong billing data' do
      let(:payment) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account'
                            }, payment_reference: Random.hex(4))
      end

      it 'raises error' do
        expect { payment }.to raise_error(Paymob::Errors::PaymentArgumentsMissing)
      end
    end
  end

  describe '#create_onetime_payment' do
    context 'when request one time payment' do
      let(:payment) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4))
      end

      it 'return payment key' do
        VCR.use_cassette('payment_creation') do
          uri = URI.parse(payment.create_onetime_payment)
          query_params = URI.decode_www_form(uri.query).to_h
          expect(query_params['payment_token']).to be_present
        end
      end
    end
  end

  describe '#create_installment_payment' do
    before do
      Paymob.installment_integration_id = '12345'
    end

    context 'when request installment' do
      let(:payment) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4))
      end

      it 'return payment key' do
        VCR.use_cassette('payment_creation') do
          uri = URI.parse(payment.create_installment_payment)
          query_params = URI.decode_www_form(uri.query).to_h
          expect(query_params['payment_token']).to be_present
        end
      end
    end
  end

  describe '#create_wallet_payment' do
    before do
      Paymob.wallet_integration_id = '12345'
    end

    context 'when request wallet payment' do
      let(:payment) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4))
      end

      it 'return link of wallet payment' do
        VCR.use_cassette('payment_creation') do
          uri = URI.parse(payment.create_wallet_payment(mobile_number: '01010101010'))
          query_params = URI.decode_www_form(uri.query).to_h
          expect(query_params['token']).to be_present
        end
      end
    end
  end
end
