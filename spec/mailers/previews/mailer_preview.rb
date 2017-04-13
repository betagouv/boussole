# encoding: utf-8
# frozen_string_literal: true

class MailerPreview < ActionMailer::Preview
  include FactoryGirl::Syntax::Methods

  def contact_email
    contact          = create(:contact)
    service_offering = ServiceOfferingDecorator.(create(:service_offering))
    working          = WorkingDecorator.(create(:working))

    Mailer.contact_email(contact, service_offering, working)
  end
end
