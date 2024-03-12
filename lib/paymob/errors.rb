# frozen_string_literal: true

module Paymob
  module Errors
    class PaymobCredentialsMissing < StandardError
    end

    class PaymentArgumentsMissing < StandardError
    end

    class PaymobRequestError < StandardError
    end
  end
end
