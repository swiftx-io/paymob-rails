# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hmac do
  # These examples from paymob docs: https://docs.paymob.com/docs/hmac-calculation#transaction-processedresponse-callback
  describe '#match_original' do
    before do
      Paymob.hmac_secret = 'DF42E0CDDDEABBC182E7297FC4C0206B'
    end

    context 'when request params hash matches the original hmac' do
      it 'returns true' do
        expect(Hmac.matches_original?(HmacHelpers.response_example, HmacHelpers.correct_hmac)).to eq(true)
      end
    end

    context 'when request params hash dose not matches the original hmac' do
      before do
        Paymob.hmac_secret = 'DF42E0CDDDEABBC182E7297FC4C0206B'
      end

      it 'returns false' do
        expect(Hmac.matches_original?(HmacHelpers.response_example, HmacHelpers.wrong_hmac)).to eq(false)
      end
    end
  end
end
