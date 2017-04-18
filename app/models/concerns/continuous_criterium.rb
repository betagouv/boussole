# encoding: utf-8
# frozen_string_literal: true

#
# Module ContinuousCriterium provides a mixin for continuous criteria.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module ContinuousCriterium
  extend ActiveSupport::Concern

  included do
    validates :minimum,
              numericality: {
                only_integer: true,
                allow_nil: true,
                less_than_or_equal_to: :maximum,
                if: -> { maximum.present? }
              }

    validates :maximum,
              numericality: {
                only_integer: true,
                allow_nil: true,
                greater_than_or_equal_to: :minimum,
                if: -> { minimum.present? }
              }
  end
end
