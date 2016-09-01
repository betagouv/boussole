# encoding: utf-8
# frozen_string_literal: true

#
# Class PublicService provides a representation of an institution that provides one or more
#   services to young people. Scope includes cooperatives, associations, territorial collectivities,
#   unions, etc.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#

#
# == Schema Information
#
# Table name: public_services
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  postal_address :string
#  email          :string
#  phone          :string
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class PublicService < ApplicationRecord
  has_many :exercise_scopes, as: :exercisable, dependent: :destroy
  has_many :social_rights, through: :exercise_scopes
  has_many :service_offerings, dependent: :destroy
  has_many :measures

  validates :title, presence: true

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
