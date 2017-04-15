# encoding: utf-8
# frozen_string_literal: true

#
# Class Pole Emploi corresponds to the criterium {PoleEmploi}, i.e. whether a
# <tt>usager</tt>is registered to Pole Emploi or not (yes or no).
#
# It is a criterium used to define the {TargetPublic} set of criteria.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class PoleEmploi < ActiveRecord::Base
  include ReadOnly
  include Criterium
  include BooleanCriterium
end
