# frozen_string_literal: true

class Paymob::PaymentTypes::Installment < Paymob::Base
  def payment_link
    return if @accept_api.payment_key.blank?

    "#{Paymob.ifream_link}#{Paymob.installment_ifream_number}?payment_token=#{@accept_api.payment_key}"
  end

  private

  def integration_id
    Paymob.installment_integration_id
  end
end
