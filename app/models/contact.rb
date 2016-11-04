# encoding: utf-8
# frozen_string_literal: true

#
# Class Contact provides a persistanceless model to contact a professional.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class Contact < ActiveType::Object
  attribute :email_or_phone, :string
  validates :email_or_phone, presence: true
end
