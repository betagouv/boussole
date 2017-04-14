# encoding: utf-8
# frozen_string_literal: true

#
# Class DigitalService provides the representation of an online, dematerialised transaction between a
# <tt>usager</tt> and a {PublicService}'s professional, offered to the <tt>usager</tt> by the {PublicService},
# or between the <tt>usager</tt> and the {DigitalService} itself, mediationless.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
# TODO: Rename to {DigitalService}
#
class Measure < ApplicationRecord
  include Nameable

  belongs_to :public_service

  has_many :exercise_scopes,
           as: :exercisable,
           dependent: :destroy

  has_many :social_rights,
           -> { distinct },
           through: :exercise_scopes

  validates :title,
            :url,
            presence: true

  delegate :title,
           to: :public_service,
           prefix: true,
           allow_nil: true
end
