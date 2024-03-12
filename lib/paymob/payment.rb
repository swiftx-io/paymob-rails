# frozen_string_literal: true

module Paymob
  class Payment
    REQUIRED_BILLING_DATA_FIELDS = %i[first_name last_name email phone_number].freeze

    def initialize(amount:, billing_data:, payment_reference:)
      @amount = amount
      @payment_reference = payment_reference
      @billing_data = billing_data
      validate_billing_data
    end

    def create_onetime_payment
      paymob = AcceptAPI.new_payment(amount: @amount, billing_data: @billing_data, payment_reference: @payment_reference,
                                     payment_type: :onetime)

      "#{Paymob.ifream_link}#{Paymob.onetime_ifream_number}?payment_token=#{paymob.payment_key}"
    end

    def create_wallet_payment(mobile_number:)
      raise PaymentArgumentsMissing, 'Mobile number is required' if mobile_number.blank?

      paymob = AcceptAPI.new_payment(amount: @amount, billing_data: @billing_data, payment_reference: @payment_reference,
                                     payment_type: :wallet)
      paymob.wallet_payment(mobile_number)

      paymob.wallet_redirect_url
    end

    def create_installment_payment
      paymob = AcceptAPI.new_payment(amount: @amount, billing_data: @billing_data, payment_reference: @payment_reference,
                                     payment_type: :installment)

      "#{Paymob.ifream_link}#{Paymob.installment_ifream_number}?payment_token=#{paymob.payment_key}"
    end

    private

    def validate_billing_data
      missing_keys = REQUIRED_BILLING_DATA_FIELDS - @billing_data.keys
      return if missing_keys.blank?

      raise Errors::PaymentArgumentsMissing,
            "Missing #{missing_keys} in billing data"
    end
  end
end
