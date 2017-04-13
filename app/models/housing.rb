# encoding: utf-8
# frozen_string_literal: true

#
# Class Housing provides the representation of a housing project/need and its corresponding discriminant criterias.
# Discriminant criterias are those determining the applicability of services to target audiences.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class Housing < ApplicationRecord
  include Wizardable

  STEPS = %i(housing profile).freeze

  with_options if: -> { required_for_step?(:housing) } do |step|
    step.validates :duration,
                   presence: true,
                   inclusion: { in: HOUSING_DURATIONS }

    step.validates :housing_city, presence: true
  end

  with_options if: -> { required_for_step?(:profile) } do |step|
    step.validates :current_status,
                   presence: true,
                   inclusion: { in: STATUSES }

    step.validates :age, presence: true
  end
end
