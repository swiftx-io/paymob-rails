# frozen_string_literal: true

module Paymob
  module PaymentTypes
    class Onetime < Paymob::Base
      def payment_link
        return if @accept_api.payment_key.blank?

        "#{Paymob.ifream_link}#{Paymob.onetime_ifream_number}?payment_token=#{@accept_api.payment_key}"
      end

      private

      def integration_id
        Paymob.onetime_integration_id
      end
    end
  end
end
