# encoding: utf-8
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout('mailer')

  default(
    from: ENV['CONTACT_EMAIL'],
    template_path: proc { "mailers/#{self.class.name.underscore}" }
  )
end
