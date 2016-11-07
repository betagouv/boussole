# encoding: utf-8
# frozen_string_literal: true

# For tracking request data.
module RequestEventProperties
  extend ActiveSupport::Concern

  def to_event_properties
    {
      referer: referer,
      fullpath: fullpath
    }
  end
end

ActionDispatch::Request.include(RequestEventProperties)
