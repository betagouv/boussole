# encoding: utf-8
# frozen_string_literal: true

#
# Module Targetable provides a mixin for criteria join models.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Targetable
  extend ActiveSupport::Concern

  included do |klass|
    belongs_to :target_public,
               inverse_of: :"#{klass.name.underscore.pluralize}"

    belongs_to :"#{klass.name.underscore.gsub(/target_public_/, '')}",
               inverse_of: :"#{klass.name.underscore.pluralize}"

    validates :target_public,
              :"#{klass.name.underscore.gsub(/target_public_/, '')}",
              presence: true
  end
end
