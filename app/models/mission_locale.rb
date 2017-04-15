# encoding: utf-8
# frozen_string_literal: true

#
# Class MissionLocale corresponds to the criterium {MissionLocale}, i.e. whether
# a user <tt>usager</tt>tt> is registered to a mission locale or not (yes or no).
#
# It is a criterium used to defined the {Target Public} set of criteria.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class MissionLocale < ActiveRecord::Base
  include ReadOnly
  include Criterium
  include BooleanCriterium
end
