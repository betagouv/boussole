# encoding: utf-8
# frozen_string_literal: true

#
# Class CapEmploi corresponds to the criterium {CapEmploi}, i.e. whether a
# <tt>usager</tt> is registered to Cap Emploi or not (yes or no).
#
# It is a criterium used to defined the {Target Public}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class CapEmploi < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include BooleanCriterium
end
