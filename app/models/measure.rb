# encoding: utf-8
# frozen_string_literal: true

#
# Class DigitalService provides the representation of an online, dematerialised transaction between an
# <tt>usager</tt> and a {PublicService}'s professional, offered to the <tt>usager</tt> by the {PublicService},
# or between the <tt>usager</tt> and the {DigitalService} itself, mediationless.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
# TODO: Rename to {DigitalService}
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: measures
#
# *id*::                <tt>integer, not null, primary key</tt>
# *title*::             <tt>string</tt>
# *description*::       <tt>text</tt>
# *url*::               <tt>string</tt>
# *public_service_id*:: <tt>integer</tt>
# *created_at*::        <tt>datetime, not null</tt>
# *updated_at*::        <tt>datetime, not null</tt>
#
# Indexes
#
#  index_measures_on_public_service_id  (public_service_id)
#
# Foreign Keys
#
#  fk_rails_22911d55d8  (public_service_id => public_services.id)
#--
# == Schema Information End
#++
#
class Measure < ApplicationRecord
  belongs_to :public_service

  has_many :exercise_scopes,
           as: :exercisable,
           dependent: :destroy

  has_many :social_rights,
           through: :exercise_scopes

  validates :title,
            :url,
            presence: true

  delegate :title,
           to: :public_service,
           prefix: true,
           allow_nil: true

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
