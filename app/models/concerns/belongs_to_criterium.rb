# encoding: utf-8
# frozen_string_literal: true

#
# Module BelongsToCriterium provides a mixin for criteria.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module BelongsToCriterium
  extend ActiveSupport::Concern

  included do |klass|
    belongs_to :target_public,
               inverse_of: :"#{klass.name.underscore}"

    validates :target_public,
              presence: true

    #
    # Checks whether {self} could be considered as persisted somewhere,
    # i.e. a database, and checks if either {#minimum} or {#maximum} are defined.
    #
    # @return [Boolean] True if persisted and {#minimum} or {#maximum} are defined.
    # @return [Boolean] False Otherwise.
    #
    def any?
      persisted? && (minimum.present? || maximum.present?)
    end
  end
end
