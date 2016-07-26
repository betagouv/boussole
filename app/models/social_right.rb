# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: social_rights
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_social_rights_on_slug  (slug) UNIQUE
#
class SocialRight < ApplicationRecord
  include Admin
  extend  FriendlyId

  friendly_id :name, use: :slugged

  has_many :exercise_scopes, inverse_of: :social_right, dependent: :destroy
  has_many :public_services,   through: :exercise_scopes, source: :exercisable, source_type: 'PublicService'
  has_many :service_offerings, through: :exercise_scopes, source: :exercisable, source_type: 'ServiceOffering'
  has_many :measures,          through: :exercise_scopes, source: :exercisable, source_type: 'Measure'

  validates :name, presence: true, uniqueness: true
end
