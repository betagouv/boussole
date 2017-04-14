# encoding: utf-8
# frozen_string_literal: true

#
# Class ProximityService provides the representation of a brick n' mortar, meat space transaction between a
# <tt>usager</tt> and a {PublicService}'s professional, offered to the <tt>usager</tt> by the {PublicService}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
# TODO: Rename to {ProximityService}
#
class ServiceOffering < ApplicationRecord
  extend FriendlyId

  friendly_id :title,
              use: :slugged

  nilify_blanks only: :email

  belongs_to :public_service,
             inverse_of: :service_offerings

  belongs_to :social_right,
             inverse_of: :service_offerings

  has_one :target_public,
          inverse_of: :service_offering,
          dependent: :destroy

  validates :title,
            :public_service,
            :social_right,
            presence: true

  validates :email,
            presence: true,
            unless: ->(service) { service.public_service.try(:email) }

  validates :response_time_upper_bound,
            numericality: {
              only_integer: true,
              allow_nil: true
            }

  validates :response_time_upper_bound,
            presence: true,
            unless: ->(service) { service.public_service.try(:response_time_upper_bound) }

  validates :slug,
            uniqueness: { scope: :public_service_id }

  validates :social_right,
            presence: true

  delegate :title,
           to: :public_service,
           prefix: true

  delegate :name,
           to: :social_right,
           prefix: true,
           allow_nil: true

  scope(
    :actionable,
    lambda do
      with(:email)
        .merge(with(:response_time_upper_bound))
    end
  )

  scope(
    :with,
    lambda do |attribute|
      joins(:public_service)
        .where(
          arel_table[attribute]
            .not_eq(nil)
            .or(
              reflect_on_association(:public_service)
                .klass.arel_table[attribute]
                .not_eq(nil)
            )
        )
    end
  )

  # TODO: Move to service object
  after_create :create_target_public
end
