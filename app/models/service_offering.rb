# encoding: utf-8
# frozen_string_literal: true

#
# TODO: Add documentation.
#

#
# == Schema Information
# Schema version: 20160925184409
#
# Table name: service_offerings
#
# *id*::                <tt>integer, not null, primary key</tt>
# *title*::             <tt>string</tt>
# *description*::       <tt>text</tt>
# *public_service_id*:: <tt>integer, not null</tt>
# *created_at*::        <tt>datetime, not null</tt>
# *updated_at*::        <tt>datetime, not null</tt>
# *postal_address*::    <tt>string</tt>
# *email*::             <tt>string</tt>
# *phone*::             <tt>string</tt>
# *url*::               <tt>string</tt>
# *external*::          <tt>boolean</tt>
# *slug*::              <tt>string</tt>
#
# Indexes
#
#  index_service_offerings_on_public_service_id           (public_service_id)
#  index_service_offerings_on_public_service_id_and_slug  (public_service_id,slug) UNIQUE
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

  friendly_id :title, use: :slugged

  belongs_to :public_service, inverse_of: :service_offerings

  has_many :exercise_scopes, as: :exercisable, dependent: :destroy
  has_many :social_rights, through: :exercise_scopes

  validates :title, :public_service, presence: true
  validates :slug, uniqueness: { scope: :public_service_id }

  delegate :title, to: :public_service, prefix: true

  #
  # Maps {SocialRight} names and joins them.
  #
  # @example
  #
  #   social_right_names
  #   #=> 'Emploi, Logement'
  #
  # @return [String] A comma separated, sorted, string with the names.
  #
  # TODO: Extract to concern.
  def social_right_names
    social_rights
      .pluck(:name)
      .sort
      .join(', ')
  end
end
