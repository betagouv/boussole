# encoding: utf-8
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
