# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: measures
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  url               :string
#  public_service_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_measures_on_public_service_id  (public_service_id)
#
# Foreign Keys
#
#  fk_rails_22911d55d8  (public_service_id => public_services.id)
#
class Measure < ApplicationRecord
  include Admin

  belongs_to :public_service
  has_many :exercise_scopes, as: :exercisable, dependent: :destroy
  has_many :social_rights, through: :exercise_scopes

  validates :title, :url, presence: true
end
