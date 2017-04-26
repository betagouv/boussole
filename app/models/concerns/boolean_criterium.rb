# encoding: utf-8
# frozen_string_literal: true

#
# Module DiscreteCriterium provides a mixin for boolean criteria.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module BooleanCriterium
  extend ActiveSupport::Concern

  included do
    validates :value,
              inclusion: { in: [true, false] },
              uniqueness: true
  end
end
