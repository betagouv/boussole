# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicWorkingStatus corresponds to the {TargetPublic} associated
# with the criterium {WorkingStatus}, i.e. sans activité, étudiant·e, lycéen·ne,
# salarié·e, en formation, apprenti·e, etc.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicWorkingStatus < ActiveRecord::Base
  include Targetable
end
