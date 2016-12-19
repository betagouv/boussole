# encoding: utf-8
# frozen_string_literal: true

#
# Module EventTracking provides a mixin to track events.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module EventTracking
  extend ActiveSupport::Concern

  private

  def tracker
    @tracker ||=
      ::EventTracker.new(
        session[:session_id],
        features,
        request_referer: request.referer,
        request_fullpath: request.fullpath,
        request_user_agent: request.user_agent
      )
  end

  #
  # Provides a list of active features (flips). Those are primarily used
  # for running A/B tests and segmentation.
  #
  # @return [#each] The list.
  #
  def features
    @features ||= ::Flip::FeatureSet.instance.definitions.map(&:key)
  end
end
