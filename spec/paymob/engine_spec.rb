# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Paymob::Engine do
  it 'has a version number' do
    expect(Paymob::Engine::VERSION).to be_present
  end

  context 'when check for all class variables' do
    it 'has a correct variables' do
      expect(Paymob.class_variables).to include(:@@base_url, :@@api_key,
                                                :@@installment_ifream_number, :@@hmac_secret,
                                                :@@onetime_integration_id, :@@wallet_integration_id, :@@ifream_link,
                                                :@@onetime_ifream_number, :@@installment_integration_id)
    end
  end
end
