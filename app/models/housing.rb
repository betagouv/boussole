# encoding: utf-8
# frozen_string_literal: true

#
# Class Housing provides the representation of a housing project/need and its corresponding discriminant criterias.
# Discriminant criterias are those determining the applicability of services to target audiences.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: housings
#
# *id*::             <tt>integer, not null, primary key</tt>
# *created_at*::     <tt>datetime, not null</tt>
# *updated_at*::     <tt>datetime, not null</tt>
# *duration*::       <tt>string</tt>
# *current_status*:: <tt>string</tt>
# *resources*::      <tt>integer, default(0)</tt>
# *age*::            <tt>integer</tt>
# *housing_city*::   <tt>string</tt>
# *residence_city*:: <tt>string</tt>
# *next_status*::    <tt>boolean, default(FALSE)</tt>
#--
# == Schema Information End
#++
#
class Housing < ApplicationRecord
  STEPS = %i(
    housing
    profile
  ).freeze

  #
  # @!attribute [rw] current_step
  # @return [Symbol] Current state in the housing project construction.
  #
  attr_accessor :current_step

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

  private

  def required_for_step?(step)
    return true if step.nil?
    return true if current_step.nil?
    return true if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
