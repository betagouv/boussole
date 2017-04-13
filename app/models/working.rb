# encoding: utf-8
# frozen_string_literal: true

#
# Class Working provides the representation of a working project/need and its corresponding discriminant criterias.
# Discriminant criterias are those determining the applicability of services to target audiences.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class Working < ApplicationRecord
  include Wizardable

  nilify_blanks only: :sector

  STEPS = %i(awareness project situation inscriptions).freeze

  with_options if: -> { required_for_step?(:awareness) } do |step|
    step.validates :awareness,
                   presence: true,
                   inclusion: { in: AWARENESSES }
  end

  with_options if: -> { required_for_step?(:project) } do |step|
    step.validates :sector,
                   inclusion: { in: SECTORS },
                   allow_nil: true,
                   allow_blank: true

    step.validates :duration,
                   presence: true,
                   inclusion: { in: WORKING_DURATIONS }

    step.validates :engagement,
                   presence: true,
                   inclusion: { in: ENGAGEMENTS }
  end

  with_options if: -> { required_for_step?(:situation) } do |step|
    step.validates :last_class,
                   presence: true,
                   inclusion: { in: LAST_CLASSES }

    step.validates :status,
                   presence: true,
                   inclusion: { in: STATUSES }

    step.validates :city,
                   presence: true,
                   inclusion: { in: CITIES }

    step.validates :age,
                   presence: true
  end
end
