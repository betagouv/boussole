# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicEngagement corresponds to the {TargetPublic} associated with
# the criterium {Engagement}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicEngagement < ActiveRecord::Base
  include Targetable
end
