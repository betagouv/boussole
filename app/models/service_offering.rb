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
# Schema version: 20170411181215
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
# *social_right_id*::           <tt>integer</tt>
#
# Indexes
#
#  index_service_offerings_on_public_service_id           (public_service_id)
#  index_service_offerings_on_public_service_id_and_slug  (public_service_id,slug) UNIQUE
#  index_service_offerings_on_response_time_upper_bound   (response_time_upper_bound)
#  index_service_offerings_on_social_right_id             (social_right_id)
#
# Foreign Keys
#
#  fk_rails_0e3762aded  (public_service_id => public_services.id)
#  fk_rails_19e1f44132  (social_right_id => social_rights.id)
#--
# == Schema Information End
#++
class ServiceOffering < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  nilify_blanks only: :email

  belongs_to :public_service,
             inverse_of: :service_offerings

  belongs_to :social_right,
             inverse_of: :service_offerings

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
end
