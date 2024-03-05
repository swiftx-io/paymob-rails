# frozen_string_literal: true

Paymob.setup do |config|
  config.base_url = 'https://accept.paymobsolutions.com/api'
  config.hmac_secret = ENV['ACCEPT_HMAC_SECRET']
  config.onetime_integration_id = ''
  config.wallet_integration_id = ''
  config.installment_integration_id = ''
  config.ifream_link = 'https://accept.paymobsolutions.com/api/acceptance/iframes/'
  config.onetime_ifream_number = ENV['IFRAME_ID']
  config.installment_ifream_number = ENV['INSTALLMENT_IFRAME_ID']
end
