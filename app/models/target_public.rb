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

  has_many :target_public_engagements,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :engagements,
           -> { distinct.order(:created_at) },
           through: :target_public_engagements

  has_many :target_public_last_classes,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :last_classes,
           -> { distinct.order(:created_at) },
           through: :target_public_last_classes

  has_many :target_public_experiences,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :experiences,
           -> { distinct.order(:created_at) },
           through: :target_public_experiences

  has_many :target_public_pole_emplois,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :pole_emplois,
           -> { distinct.order(:created_at) },
           through: :target_public_pole_emplois

  has_many :target_public_mission_locales,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :mission_locales,
           -> { distinct.order(:created_at) },
           through: :target_public_mission_locales

  has_many :target_public_cap_emplois,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :cap_emplois,
           -> { distinct.order(:created_at) },
           through: :target_public_cap_emplois

  has_many :target_public_housing_statuses,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :housing_statuses,
           -> { distinct.order(:created_at) },
           through: :target_public_housing_statuses

  has_many :target_public_housing_durations,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :housing_durations,
           -> { distinct.order(:created_at) },
           through: :target_public_housing_durations

  has_many :target_public_apecs,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :apecs,
           -> { distinct.order(:created_at) },
           through: :target_public_apecs

  validates :service_offering,
            presence: true
end
