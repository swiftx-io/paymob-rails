# frozen_string_literal: true

require 'paymob/engine/version'
require 'paymob/engine/engine'
require 'paymob/errors'
require 'paymob/accept_api'
require 'paymob/hmac'
require 'paymob/payment'

module Paymob
  module Engine
  end
  mattr_accessor :base_url,
                 :api_key,
                 :installment_ifream_number,
                 :hmac_secret,
                 :onetime_integration_id,
                 :wallet_integration_id,
                 :ifream_link,
                 :onetime_ifream_number,
                 :installment_integration_id

  # The base url of paymob api
  self.base_url = 'https://accept.paymobsolutions.com/api'
  self.api_key = 'api_key'
  # HMAC secret key, you can get it from account settings
  self.hmac_secret = ''

  self.onetime_integration_id = ''
  self.wallet_integration_id = ''
  self.installment_integration_id = ''

  # The link of iframes base url, note that you must put `/` at the end of this link
  self.ifream_link = 'https://accept.paymobsolutions.com/api/acceptance/iframes/'

  # The Ifream number for visa payments
  self.onetime_ifream_number = ''

  # The Ifream number for installment payments
  self.installment_ifream_number = ''

  def self.setup
    yield self
  end
end
