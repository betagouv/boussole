# encoding: utf-8
# frozen_string_literal: true

#
# Class ServiceOfferingDecorator provides a presenter for {ServiceOffering}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class ServiceOfferingDecorator < ApplicationDecorator
  #
  # Fallbacks to {PublicService#email} if {ServiceOffering#email} is not present.
  #
  # @return [String] If any of the emails is present
  # @return [NilClass] If none is present.
  #
  def email
    model.email ||
      model.public_service.try(:email)
  end

  #
  # Fallbacks to {PublicService#response_time_upper_bound} if
  # {ServiceOffering#response_time_upper_bound} is not present.
  #
  # @return [Fixnum] If any of the response times is present
  # @return [NilClass] If none is present.
  #
  def response_time_upper_bound
    model.response_time_upper_bound ||
      model.public_service.try(:response_time_upper_bound)
  end
end
