# frozen_string_literal: true

module HmacHelpers
  def self.response_example
    {
      'id' => 2_556_706,
      'amount_cents' => 100,
      'pending' => false,
      'success' => true,
      'is_auth' => false,
      'is_capture' => false,
      'is_standalone_payment' => true,
      'is_voided' => false,
      'is_refunded' => false,
      'is_3d_secure' => true,
      'integration_id' => 6741,
      'has_parent_transaction' => false,
      'order' => { 'id' => 4_778_239 },
      'created_at' => '2020-03-25T18:39:44.719228',
      'currency' => 'EGP',
      'source_data' => { 'pan' => '2346', 'type' => 'card', 'sub_type' => 'MasterCard' },
      'error_occured' => false,
      'owner' => 4705
    }
  end

  def self.correct_hmac
    Paymob::Hmac.calculate(response_example)
  end

  def self.wrong_hmac
    Paymob::Hmac.calculate(response_example.merge('success' => false))
  end
end
