# encoding: utf-8
# frozen_string_literal: true

#
# Class Mailer provides mailing for everything.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class Mailer < ApplicationMailer
  def contact_email(contact, service, dossier)
    @contact = contact
    @service = service
    @dossier = dossier

    mail(
      to: service.email,
      subject: 'Boussole : Un·e jeune veut être recontacté·e !'
    )
  end
end
