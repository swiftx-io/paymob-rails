# frozen_string_literal: true

class Payment
  def initialize(amount:, billing_data:, entity:, payment_reference:)
    @amount = amount
    @billing_data = billing_data
    @entity = entity
    @payment_reference = payment_reference
  end

  def create_onetime_payment
    paymob = AcceptAPI.new_payment(amount: @amount, billing_data: @billing_data, payment_reference: @payment_reference,
                                   payment_type: :onetime)

    "#{Paymob.ifream_link}#{Paymob.visa_ifream_number}?payment_token=#{paymob.payment_key}"
  end

  def create_wallet_payment(mobile_number)
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
end
