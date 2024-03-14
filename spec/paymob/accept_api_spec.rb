# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::AcceptAPI do
  describe '#new' do
    context 'when initialize new object' do
      let(:accept_api) do
        described_class.new_payment(amount: 100, billing_data: {
                                      email: 'test@example.com',
                                      first_name: 'test',
                                      last_name: 'account',
                                      phone_number: '01111111111'
                                    }, payment_reference: Random.hex(4), payment_type: :onetime)
      end

      it 'assigns auth token' do
        VCR.use_cassette('payment_creation') do
          expect(accept_api.auth_token).to be_present
        end
      end

      it 'assigns payment key' do
        VCR.use_cassette('payment_creation') do
          expect(accept_api.payment_key).to be_present
        end
      end

      it 'assigns order id' do
        VCR.use_cassette('payment_creation') do
          expect(accept_api.order_id).to be_present
        end
      end
    end
  end

  describe '#wallet_payment' do
    context 'when request wallet payment' do
      let(:accept_api) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4))
      end

      it 'assign wallet redirect url' do
        VCR.use_cassette('payment_creation') do
          accept_api.wallet_payment('01010101010')
          expect(accept_api.wallet_redirect_url).to be_present
        end
      end
    end
  end
end
