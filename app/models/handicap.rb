# encoding: utf-8
# frozen_string_literal: true

#
# Class Handicap corresponds to the criterium {Handicap}, i.e. whether a
# <tt>usager</tt> has a physical or mental disability (yes or no).
#
# It is a criterium used to defined the {TargetPublic} set of criteria.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Handicap < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include BooleanCriterium
end
