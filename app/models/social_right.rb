# encoding: utf-8
# frozen_string_literal: true

#
# TODO: Add documentation.
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: social_rights
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string, not null</tt>
# *slug*::       <tt>string, not null</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#
# Indexes
#
#  index_social_rights_on_slug  (slug) UNIQUE
#--
# == Schema Information End
#++
#
class SocialRight < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :exercise_scopes, inverse_of: :social_right, dependent: :destroy
  has_many :public_services,   through: :exercise_scopes, source: :exercisable, source_type: 'PublicService'
  has_many :service_offerings, through: :exercise_scopes, source: :exercisable, source_type: 'ServiceOffering'
  has_many :measures,          through: :exercise_scopes, source: :exercisable, source_type: 'Measure'

  validates :name, presence: true, uniqueness: true
end
