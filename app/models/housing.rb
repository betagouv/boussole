# encoding: utf-8
# frozen_string_literal: true

#
# TODO: Add documentation.
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
  # Search for <tt>ServiceOffering</tt>s matching the current housing project with a set of
  # predefined rules.
  #
  # @note It does not scope results to corresponding <tt>PublicService</tt>
  #
  # @return [ActiveRecord::Relation<ServiceOffering>] The matched records.
  #
  # TODO: Add an example
  # TODO: Move to service
  def matches
    ServiceOffering.where(slug: service_offering_matches(rules))
  end

  #
  # @!attribute [rw] current_step
  #   @return [Symbol] Current state in the housing project construction.
  attr_accessor :current_step

  with_options if: -> { required_for_step?(:housing) } do |step|
    step.validates 'duration',
                   presence: true,
                   inclusion: { in: DURATIONS }

    step.validates :housing_city, presence: true
  end

  with_options if: -> { required_for_step?(:profile) } do |step|
    step.validates 'current_status',
                   presence: true,
                   inclusion: { in: STATUSES }

    step.validates 'age', presence: true
  end

  private

  def rules
    # TODO: Move to service
    @rules ||= YAML.load(File.read(Rails.root.join('config', 'rules', 'reims', 'service_offerings.yml')))
  end

  def service_offering_matches(public_services)
    # TODO: Build query with Arel so to match public services as well
    # TODO: Document
    # TODO: Move to service
    public_services.each_with_object([]) do |(_, service_offerings), slugs|
      service_offerings.each do |service_offering, scenarios|
        scenarios.each do |scenario|
          slugs << service_offering if match_scenario?(scenario)
        end
      end
    end
  end

  def match_scenario?(scenario)
    # TODO: Document
    # TODO: Move to service
    scenario.inject(true) do |result, condition|
      result &&
        send(condition['attribute'])
          .send(condition['operator'], condition['value'])
    end
  end

  def required_for_step?(step)
    return true if step.nil?
    return true if current_step.nil?
    return true if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
