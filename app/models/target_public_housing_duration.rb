# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicHousingDuration corresponds to the {TargetPublic} associated
# with the criterium {HousingDuration}, i.e. cette nuit, quelques mois, un an,
# plus d'un an, etc.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicHousingDuration < ActiveRecord::Base
  include Targetable
end
