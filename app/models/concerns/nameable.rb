# encoding: utf-8
# frozen_string_literal: true

#
# Module Nameable provides a mixin to get {SocialRight} names.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Nameable
  extend ActiveSupport::Concern

  #
  # Maps {SocialRight} names and joins them.
  #
  # @example
  #
  #   social_right_names
  #   #=> 'Emploi, Logement'
  #
  # @return [String] A comma separated, sorted, string with the names.
  #
  # TODO: Move presentation logic ({#join}) to a decorator.
  #
  def social_right_names
    social_rights
      .pluck(:name)
      .sort
      .join(', ')
  end
end
