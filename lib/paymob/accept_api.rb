# frozen_string_literal: true

require 'paymob/errors'
require 'httparty'

module Paymob
  class AcceptAPI
    include HTTParty
    attr_reader :auth_token, :merchant_id, :amount, :order_id, :payment_key, :billing_data,
                :user, :payment_reference, :payment_type, :wallet_redirect_url

    def initialize(amount:, billing_data:, payment_reference:, payment_type: :onetime)
      @amount = amount
      @billing_data = billing_data
      @payment_reference = payment_reference
      @payment_type = payment_type
      self.class.base_uri Paymob.base_url
      self.class.headers 'Content-Type' => 'application/json'
    end

    def self.new_payment(amount:, payment_reference:, payment_type:, billing_data: {})
      api = new(amount: amount, billing_data: billing_data, payment_reference: payment_reference,
                payment_type: payment_type)
      api.authenticate
      api.create_order
      api.request_payment_key
      api
    end

    def authenticate
      response = self.class.post('/auth/tokens', { body: { api_key: api_key }.to_json }).parsed_response
      @auth_token = response['token']
      @merchant_id = response['profile']['id']
    end

    def create_order
      response = self.class.post('/ecommerce/orders',
                                 body: {
                                   auth_token: auth_token,
                                   merchant_id: merchant_id,
                                   delivery_needed: false,
                                   currency: 'EGP',
                                   amount_cents: amount.to_i * 100,
                                   merchant_order_id: payment_reference
                                 }.to_json)
      body = response.parsed_response

      @order_id = body['id']
      raise Errors::PaymobRequestError, body if @order_id.blank?
    end

    def request_payment_key
      response = self.class.post('/acceptance/payment_keys', body: {
        auth_token: auth_token,
        amount_cents: amount.to_i * 100,
        order_id: order_id,
        currency: 'EGP',
        integration_id: integration_id,
        billing_data: {
          email: billing_data[:email],
          first_name: billing_data[:first_name],
          last_name: billing_data[:last_name],
          building: billing_data[:building] || 'NA',
          apartment: billing_data[:apartment] || 'NA',
          street: billing_data[:street] || 'NA',
          floor: billing_data[:floor] || 'NA',
          city: billing_data[:city] || 'NA',
          country: billing_data[:country] || 'NA',
          phone_number: billing_data[:phone_number]
        }
      }.to_json).parsed_response

      @payment_key = response['token']
    end

    def wallet_payment(phone_number)
      response = self.class.post('/acceptance/payments/pay',
                                 body: {
                                   payment_token: payment_key,
                                   source: {
                                     identifier: phone_number,
                                     subtype: 'WALLET'
                                   }
                                 }.to_json).parsed_response

      @wallet_redirect_url = response['redirect_url']
    end

    private

    def api_key
      raise PaymobCredentialsMissing, 'API Key is required' if Paymob.api_key.blank?

      Paymob.api_key
    end

    def integration_id
      case payment_type
      when :installment, :wallet, :onetime
        integration_id = Paymob.try("#{payment_type}_integration_id")
        raise PaymobCredentialsMissing, "#{payment_type}_integration_id is required" if integration_id.blank?

        integration_id
      else
        raise PaymobCredentialsMissing,
              "#{payment_type} dose not exists, available values [:installment, :wallet, :onetime]"
      end
    end
  end
end
