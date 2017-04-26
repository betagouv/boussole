# encoding: utf-8
# frozen_string_literal: true

#
# Class HousingAge corresponds to the criterium {HousingAge}, i.e. the age
# of a  <tt>usager</tt>> to which a service offering (with a <tt>Housing</tt>
# {SocialRight}) can correspond.
#
# It is a criterium used to define the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class HousingAge < ActiveRecord::Base
  include BelongsToCriterium
  include ContinuousCriterium

  validates :minimum,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 16,
              less_than_or_equal_to: 30,
              allow_nil: true
            }

  validates :maximum,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 16,
              less_than_or_equal_to: 30,
              allow_nil: true
            }
end
