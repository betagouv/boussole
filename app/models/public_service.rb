# encoding: utf-8
# frozen_string_literal: true

#
# Class PublicService provides a representation of an institution that provides one or more
# services to young people. Scope includes cooperatives, associations, territorial collectivities,
# unions, etc.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#

#
# == Schema Information
# Schema version: 20161006093650
#
# Table name: public_services
#
# *id*::                        <tt>integer, not null, primary key</tt>
# *title*::                     <tt>string</tt>
# *description*::               <tt>text</tt>
# *postal_address*::            <tt>string</tt>
# *email*::                     <tt>string</tt>
# *phone*::                     <tt>string</tt>
# *url*::                       <tt>string</tt>
# *created_at*::                <tt>datetime, not null</tt>
# *updated_at*::                <tt>datetime, not null</tt>
# *slug*::                      <tt>string</tt>
# *response_time_upper_bound*:: <tt>integer</tt>
#
# Indexes
#
#  index_public_services_on_response_time_upper_bound  (response_time_upper_bound)
#  index_public_services_on_slug                       (slug) UNIQUE
#--
# == Schema Information End
#++
#
class PublicService < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_many :exercise_scopes,
           as: :exercisable,
           dependent: :destroy

  has_many :social_rights,
           through: :exercise_scopes

  has_many :service_offerings,
           dependent: :destroy

  has_many :measures,
           dependent: :destroy

  validates :title,
            presence: true

  validates :slug,
            uniqueness: true

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
