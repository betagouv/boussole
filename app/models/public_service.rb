# encoding: utf-8
# frozen_string_literal: true

#
# Class PublicService provides a representation of an institution that provides one or more
# services to young people. Scope includes cooperatives, associations, territorial collectivities,
# unions, etc.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class PublicService < ApplicationRecord
  extend FriendlyId
  include Nameable

  friendly_id :title,
              use: :slugged

  nilify_blanks only: :email

  has_many :exercise_scopes,
           as: :exercisable,
           dependent: :destroy

  has_many :social_rights,
           -> { distinct },
           through: :exercise_scopes

  has_many :service_offerings,
           dependent: :destroy

  has_many :measures,
           dependent: :destroy

  validates :title,
            presence: true

  validates :slug,
            uniqueness: true

  validates :response_time_upper_bound,
            numericality: {
              only_integer: true,
              allow_nil: true
            }
end
