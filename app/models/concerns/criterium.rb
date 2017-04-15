# encoding: utf-8
# frozen_string_literal: true

#
# Module DiscreteCriterium provides a mixin for criteria.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Criterium
  extend ActiveSupport::Concern

  included do |klass|
    has_many :"target_public_#{klass.name.underscore.pluralize}",
             inverse_of: :"#{klass.name.underscore}",
             dependent: :destroy

    has_many :target_publics,
             through: :"target_public_#{klass.name.underscore.pluralize}"
  end
end
