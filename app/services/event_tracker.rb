# encoding: utf-8
# frozen_string_literal: true

#
# Class EventTracker provides a service for sending event data to external analytics services.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class EventTracker
  #
  # Initialises an event tracker with information to be used across events.
  #
  # @param [#to_s] distinct_id  A UUID to identify the actor of the events.
  # @param [#each] features     A collection of toggle names (for feature flips).
  # @param [Hash]  properties   Additional (implicit) properties to track (for any event).
  #
  def initialize(distinct_id, features, **properties)
    @tracker = TRACKER.(distinct_id.to_s, properties.merge(feature_properties(features)))
  end

  #
  # @return [#call] A block wrapping the external analytics adapter.
  #
  TRACKER = -> (distinct_id, properties) { MetaEvents::Tracker.new(distinct_id, nil, implicit_properties: properties) }

  #
  # @return [#call] A block wrapping the A/B testing flipper.
  #
  FLIPPER = -> (feature) { Flip.on?(feature) }

  #
  # @!attribute [r] tracker
  #
  # @return [#event!] An instance of an analytics adapter.
  #
  attr_reader :tracker

  #
  # Passes an event to track to the adapter instance.
  #
  # @param [#to_sym] segment    The customer segment we're tracking.
  # @param [#to_sym] event      The customer segment's event we're tracking.
  # @param [Hash]    properties Specific event properties we want to track.
  #
  def call(segment, event, **properties)
    tracker.event!(segment.to_sym, event.to_sym, **properties)
  end

  private

  def feature_properties(features)
    features.each_with_object({}) do |property, properties|
      properties.public_send(:[]=, :"feature_#{property}", FLIPPER.(property))
    end
  end
end
