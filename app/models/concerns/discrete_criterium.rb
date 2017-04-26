# encoding: utf-8
# frozen_string_literal: true

#
# Module DiscreteCriterium provides a mixin for discrete criteria.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module DiscreteCriterium
  extend ActiveSupport::Concern

  included do
    validates :name,
              presence: true,
              uniqueness: true
  end
end
