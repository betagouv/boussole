# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicHousingStatus corresponds to the {TargetPublic} associated
# with the criterium {HousingStatus}, i.e. sans activité, étudiant·e, lycéen·ne,
# salarié·e, en formation, apprenti·e, etc.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicHousingStatus < ActiveRecord::Base
  include Targetable
end
