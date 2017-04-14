# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublic provides a representation of a set of criteria depending on
# the social right of the {Service_Offering}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class TargetPublic < ActiveRecord::Base
  belongs_to :service_offering,
             inverse_of: :target_public

  has_many :target_public_statuses,
           inverse_of: :target_public

  has_many :statuses,
           through: :target_public_statuses

  validates :service_offering,
            presence: true
end
