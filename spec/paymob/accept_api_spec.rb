# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::AcceptAPI do
  describe '#new' do
    context 'when initialize new object' do
      let(:accept_api) do
        described_class.new(amount: 100, billing_data: {
                              email: 'test@example.com',
                              first_name: 'test',
                              last_name: 'account',
                              phone_number: '01111111111'
                            }, payment_reference: Random.hex(4), payment_type: :onetime)
      end

      it 'assigns amount' do
        expect(accept_api.instance_variable_get(:@amount)).to eq(100)
      end

      it 'assigns billing_data' do
        expect(accept_api.instance_variable_get(:@billing_data)).to be_present
      end

      it 'assigns payment reference' do
        expect(accept_api.instance_variable_get(:@payment_reference)).to be_present
      end
    end
  end

  describe '#authenticate' do
    let(:accept_api) do
      described_class.new(amount: 100, billing_data: {
                            email: 'test@example.com',
                            first_name: 'test',
                            last_name: 'account',
                            phone_number: '01111111111'
                          }, payment_reference: Random.hex(4), payment_type: :onetime)
    end

    before do
      VCR.use_cassette('payment_creation') do
        accept_api.authenticate
      end
    end

    it 'assigns auth token' do
      VCR.use_cassette('payment_creation') do
        expect(accept_api.auth_token).to be_present
      end
    end

    it 'assigns merchant_id' do
      VCR.use_cassette('payment_creation') do
        expect(accept_api.merchant_id).to be_present
      end
    end
  end

  describe '#create_order' do
    let(:accept_api) do
      described_class.new(amount: 100, billing_data: {
                            email: 'test@example.com',
                            first_name: 'test',
                            last_name: 'account',
                            phone_number: '01111111111'
                          }, payment_reference: Random.hex(4), payment_type: :onetime)
    end

    before do
      VCR.use_cassette('payment_creation') do
        accept_api.create_order
      end
    end

    it 'assigns order_id' do
      VCR.use_cassette('payment_creation') do
        expect(accept_api.order_id).to be_present
      end
    end
  end

  describe '#request_payment_key' do
    let(:accept_api) do
      described_class.new(amount: 100, billing_data: {
                            email: 'test@example.com',
                            first_name: 'test',
                            last_name: 'account',
                            phone_number: '01111111111'
                          }, payment_reference: Random.hex(4), payment_type: :onetime)
    end

    before do
      VCR.use_cassette('payment_creation') do
        accept_api.request_payment_key('1234')
      end
    end

    it 'assigns auth token' do
      VCR.use_cassette('payment_creation') do
        expect(accept_api.payment_key).to be_present
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
