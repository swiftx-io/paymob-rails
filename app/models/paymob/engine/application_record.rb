# frozen_string_literal: true

module Paymob
  module Engine
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
