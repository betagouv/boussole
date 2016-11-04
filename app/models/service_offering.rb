# encoding: utf-8
# frozen_string_literal: true

#
# Class ProximityService provides the representation of a brick n' mortar, meat space transaction between an
# <tt>usager</tt> and a {PublicService}'s professional, offered to the <tt>usager</tt> by the {PublicService}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
# TODO: Rename to {ProximityService}
#

#
# == Schema Information
# Schema version: 20161006093649
#
# Table name: service_offerings
#
# *id*::                        <tt>integer, not null, primary key</tt>
# *title*::                     <tt>string</tt>
# *description*::               <tt>text</tt>
# *public_service_id*::         <tt>integer, not null</tt>
# *created_at*::                <tt>datetime, not null</tt>
# *updated_at*::                <tt>datetime, not null</tt>
# *postal_address*::            <tt>string</tt>
# *email*::                     <tt>string</tt>
# *phone*::                     <tt>string</tt>
# *url*::                       <tt>string</tt>
# *slug*::                      <tt>string</tt>
# *response_time_upper_bound*:: <tt>integer</tt>
#
# Indexes
#
#  index_service_offerings_on_public_service_id           (public_service_id)
#  index_service_offerings_on_public_service_id_and_slug  (public_service_id,slug) UNIQUE
#  index_service_offerings_on_response_time_upper_bound   (response_time_upper_bound)
#
# Foreign Keys
#
#  fk_rails_0e3762aded  (public_service_id => public_services.id)
#--
# == Schema Information End
#++
#
class ServiceOffering < ApplicationRecord
  extend FriendlyId
  include Nameable

  friendly_id :title, use: :slugged

  belongs_to :public_service,
             inverse_of: :service_offerings

  has_many :exercise_scopes,
           as: :exercisable,
           dependent: :destroy

  has_many :social_rights,
           through: :exercise_scopes

  validates :title,
            :public_service,
            presence: true

  validates :email,
            presence: true,
            unless: ->(service) { service.public_service.try(:email) }

  validates :response_time_upper_bound,
            presence: true,
            unless: ->(service) { service.public_service.try(:response_time_upper_bound) }

  validates :slug,
            uniqueness: { scope: :public_service_id }

  delegate :title,
           to: :public_service,
           prefix: true

  scope :actionable, -> { with(:email).merge(with(:response_time_upper_bound)) }

  scope :with, lambda { |attribute|
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
  }
end
