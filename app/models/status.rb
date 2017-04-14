# encoding: utf-8
# frozen_string_literal: true

class Status < ActiveRecord::Base
  has_many :target_public_statuses,
           inverse_of: :status,
           dependent: :destroy

  has_many :target_publics,
           through: :target_public_statuses

  validates :name,
            presence: true,
            uniqueness: true
end
