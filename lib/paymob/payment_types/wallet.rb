# frozen_string_literal: true

module Paymob
  module PaymentTypes
    class Wallet < Paymob::Base
      def payment_link(mobile_number:)
        raise PaymentArgumentsMissing, 'Mobile number is required' if mobile_number.blank?

        @accept_api.wallet_payment(mobile_number)
        @accept_api.wallet_redirect_url
      end

      private

      def integration_id
        Paymob.wallet_integration_id
      end
    end
  end
end
