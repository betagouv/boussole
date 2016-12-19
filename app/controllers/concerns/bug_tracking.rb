# encoding: utf-8
# frozen_string_literal: true

#
# Module BugTracking provides a mixin to track bugs.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module BugTracking
  extend ActiveSupport::Concern

  included do
    before_action :set_raven_context
  end

  private

  def set_raven_context
    ::Raven.extra_context(params: params.to_hash, url: request.url)
  end
end
