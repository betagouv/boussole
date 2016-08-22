# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
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
end
