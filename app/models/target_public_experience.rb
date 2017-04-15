# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicExperience corresponds to the {TargetPublic} associated with
# the criterium {Experience}.
#
# It is a criterium used to define the {Target Public}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicExperience < ActiveRecord::Base
  include Targetable
end
