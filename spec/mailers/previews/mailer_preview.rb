# encoding: utf-8
# frozen_string_literal: true

class MailerPreview < ActionMailer::Preview
  include FactoryGirl::Syntax::Methods

  def contact_email
    Mailer.contact_email(
      create(:contact),
      create(:service_offering, public_service: create(:public_service)),
      create(:working)
    )
  end
end
