# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  knowledge  :string
#  age        :integer
#  status     :string
#  last_class :string
#  city       :string
#  handicap   :boolean
#  experience :boolean
#  pe         :boolean
#  ml         :boolean
#  cap        :boolean
#  apec       :boolean
#  area       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  domain     :string
#  formation  :string
#  degree     :string
#  intention  :boolean
#
class Project < ApplicationRecord
  STEPS = %i(
    knowledge
    formation
    profile
    inscriptions
  ).freeze

  #
  # @!attribute [rw] current_step
  #   @return [Symbol] Current state in the housing project construction.
  attr_accessor :current_step

  with_options if: -> { required_for_step?(:knowledge) } do |step|
    step.validates :knowledge, presence: true
  end

  with_options if: -> { required_for_step?(:formation) } do |step|
    step.validates :domain, presence: true
    # step.validates :formation, presence: true
  end

  with_options if: -> { required_for_step?(:profile) } do |step|
    step.validates :age, presence: true
    step.validates :status, presence: true
    step.validates :last_class, presence: true
    step.validates :degree, presence: true
    step.validates :city, presence: true
  end

  private

  def required_for_step?(step)
    return true if step.nil?
    return false if step == :formation && knowledge == KNOWLEDGE_QUESTIONS[1]
    return true if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
