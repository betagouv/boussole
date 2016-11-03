# encoding: utf-8
# frozen_string_literal: true

#
# Class ServiceOfferingDecorator provides a presenter for {ServiceOffering}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class ServiceOfferingDecorator < ApplicationDecorator
  #
  # @!attribute [r] service_offering
  #
  # @return [ServiceOffering] The decorated {ServiceOffering}
  #
  attr_reader :service_offering

  #
  # @!attribute [r] public_service
  #
  # @return [PublicService] The associated {PublicService}, if it exists.
  #
  attr_reader :public_service

  #
  # Fallbacks to {PublicService#email} if {ServiceOffering#email} is not present.
  #
  #
  # @return [String] If any of the emails is present
  # @return [NilClass] If none is present.
  #
  def email
    service_offering.email ||
      public_service.try(:email)
  end

  #
  # Fallbacks to {PublicService#response_time_upper_bound} if
  # {ServiceOffering#response_time_upper_bound} is not present.
  #
  # @return [Fixnum] If any of the response times is present
  # @return [NilClass] If none is present.
  #
  def response_time_upper_bound
    service_offering.response_time_upper_bound ||
      public_service.try(:response_time_upper_bound)
  end

  private

  def initialize(_)
    super
    @service_offering = model
    @public_service   = service_offering.public_service
  end
end
