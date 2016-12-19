# encoding: utf-8
# frozen_string_literal: true

#
# Module Blacklisting provides a mixin to blacklist IPs.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Blacklisting
  extend ActiveSupport::Concern

  private

  #
  # Checks whether the current request comes from a blacklisted IP.
  #
  # @return [Boolean] Is it blacklisted?
  #
  def blacklisted?
    return if blacklisted.empty?
    request.remote_ip =~ Regexp.new(blacklisted.join('|'))
  end

  #
  # Tries to build a list of blacklisted IPs.
  #
  # @return [#empty?, #join] The IPs list.
  #
  def blacklisted
    @blacklisted ||=
      ENV['BLACKLISTED_IPS']
      .try(:split, ',')
      .try(:select, &:present?)
      .try(:map, &:strip)
      .to_a
  end
end
