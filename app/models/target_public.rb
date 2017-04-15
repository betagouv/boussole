# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublic provides a representation of a set of criteria depending on
# the social right of the {Service_Offering}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublic < ActiveRecord::Base
  belongs_to :service_offering,
             inverse_of: :target_public

  has_many :target_public_housing_statuses,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :housing_statuses,
           -> { distinct },
           through: :target_public_housing_statuses

  has_many :target_public_engagements,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :engagements,
           -> { distinct },
           through: :target_public_engagements

  has_many :target_public_last_classes,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :last_classes,
           -> { distinct },
           through: :target_public_last_classes

  has_many :target_public_experiences,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :experiences,
           -> { distinct },
           through: :target_public_experiences

  has_many :target_public_pole_emplois,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :pole_emplois,
           -> { distinct },
           through: :target_public_pole_emplois

  has_many :target_public_housing_durations,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :durations,
           -> { distinct },
           through: :target_public_housing_durations

  validates :service_offering,
            presence: true
end
