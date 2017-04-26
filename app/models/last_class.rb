# encoding: utf-8
# frozen_string_literal: true

#
# Class LastClass corresponds to the criterium Last Class, i.e. the educational
# level of a usager.
#
# It is a criterium used to define the {Target Public}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class LastClass < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include DiscreteCriterium
end
