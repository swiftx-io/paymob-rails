# frozen_string_literal: true

module Paymob
  class Hmac
    def self.calculate(hash)
      concatenated_params = flatten(hash.to_h).sort.to_h.values.join
      OpenSSL::HMAC.hexdigest('SHA512', hmac_key, concatenated_params)
    end

    def self.matches_original?(hash, original_hmac)
      calculate(hash) == original_hmac
    end

    def self.flatten(hash)
      new_hash = {}
      hash.each do |key, value|
        if value.is_a?(Hash)
          new_hash.merge!(value.transform_keys { |k| "#{key}.#{k}" })
        else
          new_hash[key] = value
        end
      end
      new_hash
    end

    def self.hmac_key
      Paymob.hmac_secret
    end
  end
end
