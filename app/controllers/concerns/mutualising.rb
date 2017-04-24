# encoding: utf-8
# frozen_string_literal: true

#
# Module Mutualising provides a mixin to help deploy several app instances.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Mutualising
  extend ActiveSupport::Concern

  #
  # What instance of the app are we running?
  #
  # @return [#call] The proc containing the name of the instance.
  #
  def rhizome
    Rails.application.config.rhizome
  end

  included do
    helper_method :rhizome
  end
end
