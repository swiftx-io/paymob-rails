# frozen_string_literal: true

require 'test_helper'

module Paymob
  class EngineTest < ActiveSupport::TestCase
    test 'it has a version number' do
      assert Paymob::Engine::VERSION
    end
  end
end
