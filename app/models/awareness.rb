# encoding: utf-8
# frozen_string_literal: true

#
# Class Awareness corresponds to the criterium {Awareness}, i.e. whether a
# <tt>usager</tt> already knows what he wants to do as a job or not (yes or no).
#
# It is a criterium used to defined the {TargetPublic} set of criteria.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Awareness < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include DiscreteCriterium
end
