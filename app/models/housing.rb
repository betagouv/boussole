# encoding: utf-8
# frozen_string_literal: true
# == Schema Information
#
# Table name: housings
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  duration       :string
#  status         :string
#  resources      :integer
#  age            :integer
#  housing_city   :string
#  residence_city :string
#

class Housing < ActiveRecord::Base
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
      status == 'Étudiant·e' &&
      resources.to_i <= 1_200
  end

  def paindavoine?
    duration != 'Cette nuit' &&
      status != 'Étudiant·e' &&
      resources.to_i >= 300
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
      status == 'Étudiant·e'
  end

  # TODO: Change true/false for truthy/falsy matchers
  def locapass?
    return true if duration != 'Cette nuit' &&
                   status == 'Salarié·e'

    return true if duration != 'Cette nuit' &&
                   status.in?(['En alternance', 'Sans activité']) &&
                   age <= 30

    false
  end

  def visale?
    duration.in?(['1 an', "+ d'1 an"]) &&
      status == 'Salarié·e'
  end

  attr_accessor :current_step

  with_options if: -> { required_for_step?(:housing) } do |step|
    step.validates :duration,
                   :housing_city,
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
