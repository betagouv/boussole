# encoding: utf-8
# frozen_string_literal: true

#
# Module Logging provides a mixin to append info to logging payloads.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Logging
  extend ActiveSupport::Concern

  private

  #
  # Appends information to #{Lograge} payload.
  #
  def append_info_to_payload(payload)
    super
    payload[:session_id] = session[:session_id]
    payload[:params]     =
      request
      .filtered_parameters
      .except('controller', 'action', 'format', 'utf8')
  end
end
