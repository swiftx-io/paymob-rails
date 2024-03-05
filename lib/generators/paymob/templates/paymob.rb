# frozen_string_literal: true

Paymob.setup do |config|
  config.base_url = 'https://accept.paymobsolutions.com/api'
  config.hmac_secret = ''
  config.visa_integration_id = ''
  config.wallet_integration_id = ''
  config.installment_integration_id = ''
  config.ifream_link = 'https://accept.paymobsolutions.com/api/acceptance/iframes/'
  config.visa_ifream_number = ''
  config.installment_ifream_number = ''
end
