# encoding: utf-8
# frozen_string_literal: true

#
# Class Experience corresponds to the criterium {Experience}, i.e. whether a
# <tt>usager</tt> has already an experience in the sector of the job he·she
# is looking for.
#
# It is a criterium used to define the {Target Public}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Experience < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include BooleanCriterium
end
