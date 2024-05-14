# frozen_string_literal: true

module Paymob
  class Base
    REQUIRED_BILLING_DATA_FIELDS = %i[first_name last_name email phone_number].freeze
    REQUIRED_PAYMENT_FIELDS = %i[amount billing_data payment_reference].freeze
    attr_accessor :accept_api

    def initialize_order(payment_params)
      validate_payment_params(payment_params)
      @accept_api = AcceptAPI.new(amount: payment_params[:amount], billing_data: payment_params[:billing_data],
                                  payment_reference: payment_params[:payment_reference])
      @accept_api.authenticate
      @accept_api.create_order
      @accept_api.request_payment_key(integration_id)
    end

    private

    def validate_payment_params(payment_params)
      required_keys = REQUIRED_PAYMENT_FIELDS - payment_params.keys
      if required_keys.blank?
        validate_billing_data(payment_params[:billing_data])
      else
        raise Errors::PaymentArgumentsMissing,
              "Missing #{required_keys} keys"
      end
    end

    def validate_billing_data(billing_data)
      missing_keys = REQUIRED_BILLING_DATA_FIELDS - billing_data.keys
      return if missing_keys.blank?

      raise Errors::PaymentArgumentsMissing,
            "Missing #{missing_keys} in billing data"
    end

    def integration_id
      raise NotImplementedError
    end
  end
end
