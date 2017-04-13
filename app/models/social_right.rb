# encoding: utf-8
# frozen_string_literal: true

#
# Class SocialRight provides the representation of a social right actionable through {ServiceOfferings}s and {Measure}s,
# wheathey they're provided by {PublicService}s or standalone.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class SocialRight < ApplicationRecord
  extend FriendlyId

  friendly_id :name,
              use: :slugged

  has_many :exercise_scopes,
           inverse_of: :social_right,
           dependent: :destroy

  has_many :public_services,
           through: :exercise_scopes,
           source: :exercisable,
           source_type: 'PublicService'

  has_many :measures,
           through: :exercise_scopes,
           source: :exercisable, source_type: 'Measure'

  has_many :service_offerings

  validates :name,
            presence: true,
            uniqueness: true
end
