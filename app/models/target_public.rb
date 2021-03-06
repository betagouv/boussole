# encoding: utf-8
# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength

#
# Class TargetPublic provides a representation of a set of criteria depending on
# the social right of the {Service_Offering}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublic < ActiveRecord::Base
  belongs_to :service_offering,
             inverse_of: :target_public
  # Apecs
  has_many :target_public_apecs,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :apecs,
           -> { distinct.order(:created_at) },
           through: :target_public_apecs

  # Awarenesses
  has_many :target_public_awarenesses,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :awarenesses,
           -> { distinct.order(:created_at) },
           through: :target_public_awarenesses

  # Cap Emplois
  has_many :target_public_cap_emplois,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :cap_emplois,
           -> { distinct.order(:created_at) },
           through: :target_public_cap_emplois

  # Engagements
  has_many :target_public_engagements,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :engagements,
           -> { distinct.order(:created_at) },
           through: :target_public_engagements

  # Experiences
  has_many :target_public_experiences,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :experiences,
           -> { distinct.order(:created_at) },
           through: :target_public_experiences

  # Handicaps
  has_many :target_public_handicaps,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :handicaps,
           -> { distinct.order(:created_at) },
           through: :target_public_handicaps

  # Housing Durations
  has_many :target_public_housing_durations,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :housing_durations,
           -> { distinct.order(:created_at) },
           through: :target_public_housing_durations

  # Housing Statuses
  has_many :target_public_housing_statuses,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :housing_statuses,
           -> { distinct.order(:created_at) },
           through: :target_public_housing_statuses

  # Last Classes
  has_many :target_public_last_classes,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :last_classes,
           -> { distinct.order(:created_at) },
           through: :target_public_last_classes

  # Mission Locales
  has_many :target_public_mission_locales,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :mission_locales,
           -> { distinct.order(:created_at) },
           through: :target_public_mission_locales

  # Pôle Emplois
  has_many :target_public_pole_emplois,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :pole_emplois,
           -> { distinct.order(:created_at) },
           through: :target_public_pole_emplois

  # Working Durations
  has_many :target_public_working_durations,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :working_durations,
           -> { distinct.order(:created_at) },
           through: :target_public_working_durations

  # Working Statuses
  has_many :target_public_working_statuses,
           inverse_of: :target_public,
           dependent: :destroy

  has_many :working_statuses,
           -> { distinct.order(:created_at) },
           through: :target_public_working_statuses

  # Working Age
  has_one :working_age,
          inverse_of: :target_public,
          dependent: :destroy

  accepts_nested_attributes_for :working_age

  # Housing Age
  has_one :housing_age,
          inverse_of: :target_public,
          dependent: :destroy

  accepts_nested_attributes_for :housing_age

  # Resource
  has_one :resource,
          inverse_of: :target_public,
          dependent: :destroy

  accepts_nested_attributes_for :resource

  validates :service_offering,
            presence: true

  WORKING_CRITERIA = %i(
    apecs
    awarenesses
    cap_emplois
    engagements
    experiences
    handicaps
    last_classes
    mission_locales
    pole_emplois
    working_age
    working_durations
    working_statuses
  ).freeze

  HOUSING_CRITERIA = %i(
    housing_age
    housing_durations
    housing_statuses
    resource
  ).freeze

  #
  # Collection of criteria for each type of project (housing, working, etc.).
  #
  # @return [Array<Symbol>] <description>
  #
  def criteria
    return WORKING_CRITERIA if working?
    return HOUSING_CRITERIA if housing?
    []
  end

  private

  # TODO: You know way too much...
  def working?
    service_offering.social_right.slug == 'emploi'
  end

  # TODO: You know way too much...
  def housing?
    service_offering.social_right.slug == 'logement'
  end
end
