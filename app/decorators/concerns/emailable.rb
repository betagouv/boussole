# encoding: utf-8
# frozen_string_literal: true

#
# Module Emailable provides a mixin to get emailable properties.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Emailable
  extend ActiveSupport::Concern

  #
  # Formats properties for e-mailing.
  #
  def to_email_properties
    model
      .attributes
      .except('id', 'created_at', 'updated_at')
  end
end
