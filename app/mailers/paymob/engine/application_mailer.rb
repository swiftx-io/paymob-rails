# frozen_string_literal: true

module Paymob
  module Engine
    class ApplicationMailer < ActionMailer::Base
      default from: 'from@example.com'
      layout 'mailer'
    end
  end
end
