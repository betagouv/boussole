# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicEngagement corresponds to the {TargetPublic} associated with
# the criterium {Engagement}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublicEngagement < ActiveRecord::Base
  belongs_to :target_public,
             inverse_of: :target_public_engagements

  belongs_to :engagement,
             inverse_of: :target_public_engagements

  validates :target_public,
            :engagement,
            presence: true
end
