# encoding: utf-8
# frozen_string_literal: true

#
# Class Resource corresponds to the criterium {Resource}, i.e. the budget
# allocated by a <tt>usager</tt> to his·hers housing expenditures.
#
# It is a criterium used to defined the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Resource < ActiveRecord::Base
  include BelongsToCriterium
  include ContinuousCriterium

  validates :minimum,
            numericality: {
              only_integer: true,
              allow_nil: true
            }

  validates :maximum,
            numericality: {
              only_integer: true,
              allow_nil: true
            }
end
