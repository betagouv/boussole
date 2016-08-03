# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: housings
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  duration       :string
#  current_status :string
#  resources      :integer
#  age            :integer
#  housing_city   :string
#  residence_city :string
#  next_status    :boolean
#
class Housing < ApplicationRecord
  include Admin

  STEPS = %i(
    housing
    profile
  ).freeze

  def siao?
    duration == 'Cette nuit' &&
      resources.to_i <= 300
  end

  def crous?
    duration.in?(['Quelques mois', '1 an']) &&
      student? &&
      resources.to_i <= 1_200
  end

  def mgel?
    duration.in?(['Quelques mois', '1 an']) &&
      student? &&
      resources.to_i <= 1_200
  end
  
  def paindavoine?
    return false if resources.to_i < 300
    return true if  current_status.in?(['En alternance', 'Sans activité', 'En formation', 'Salarié·e'])
    return true if  student?
    false
  end
  
   def crij?
    duration.in?(['Quelques mois', '1 an', '+ d'un an']) &&
    resources.to_i > 1000 &
  end

  def cent_quinze?
    duration == 'Cette nuit' &&
      resources.to_i <= 1_000 &&
      age.in?(16..30)
  end

  def apl?
    duration != 'Cette nuit'
  end

  def cle?
    duration != 'Cette nuit' &&
      student?
  end

  # TODO: Change true/false for truthy/falsy matchers
  def locapass?
    return true if duration != 'Cette nuit' &&
                   current_status == 'Salarié·e'

    return true if duration != 'Cette nuit' &&
                   current_status.in?(['En alternance', 'Sans activité']) &&
                   age <= 30

    false
  end

  def visale?
    duration.in?(['1 an', "+ d'1 an"]) &&
      current_status == 'Salarié·e'
  end

  def student?
    current_status == 'Étudiant·e' ||
      current_status == 'Lycéen·ne' &&
        next_status
  end

  attr_accessor :current_step

  with_options if: -> { required_for_step?(:housing) } do |step|
    step.validates :duration,
                   presence: true,
                   inclusion: { in: DURATIONS }

    step.validates :housing_city, presence: true
  end

  with_options if: -> { required_for_step?(:profile) } do |step|
    step.validates :current_status,
                   presence: true,
                   inclusion: { in: STATUSES }

    step.validates :age, presence: true
  end

  private

  def required_for_step?(step)
    return true if step.nil?
    return true if current_step.nil?
    return true if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
