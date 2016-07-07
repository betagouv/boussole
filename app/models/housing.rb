# encoding: utf-8
# frozen_string_literal: true

class Housing < ActiveRecord::Base
  DURATION = [
    'Cette nuit',
    'Quelques mois',
    '1 an',
    "> d'1 an"
  ].freeze

  STEPS = %i(
    housing
    profile
  ).freeze

  def siao?
    duration == 'Cette nuit' &&
      resources < 300
  end

  def crous?
    duration.in?(['Quelques mois', '1 an']) &&
      status == 'Étudiant·e' &&
      resources < 1_200
  end

  def pain_d_avoine?
    duration != 'Cette nuit' &&
      status != 'Étudiant·e' &&
      resources >= 300
  end

  def cent_quinze?
    duration == 'Cette nuit' &&
      resources <= 1_000 &&
      age.in?(16..30)
  end

  def apl?
    duration != 'Cette nuit'
  end

  def cle?
    status == 'Étudiant·e'
  end

  # TODO: Change true/false for truthy/falsy matchers
  def locapass?
    return true if status == 'Salarié·e'
    return true if status.in?(['En alternance', 'Sans activité']) && age <= 30
    false
  end

  def visale?
    duration.in?(['1 an', "> d'1 an"]) &&
      status == 'Salarié·e'
  end

  attr_accessor :current_step

  with_options if: -> { required_for_step?(:housing) } do |step|
    step.validates :duration,
                   :housing_city,
                   :resources,
                   presence: true
  end

  with_options if: -> { required_for_step?(:profile) } do |step|
    step.validates :status,
                   :residence_city,
                   :age,
                   presence: true
  end

  private

  def required_for_step?(step)
    return true if step.nil?
    return true if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
