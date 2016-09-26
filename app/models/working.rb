# encoding: utf-8
# frozen_string_literal: true

#
# Class Working provides the representation of a working project/need and its corresponding discriminant criterias.
# Discriminant criterias are those determining the applicability of services to target audiences.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#

# == Schema Information
# Schema version: 20160926092813
#
# Table name: workings
#
# *id*::             <tt>integer, not null, primary key</tt>
# *awareness*::      <tt>string</tt>
# *sector*::         <tt>string</tt>
# *experience*::     <tt>boolean</tt>
# *duration*::       <tt>string</tt>
# *engagement*::     <tt>string</tt>
# *status*::         <tt>string</tt>
# *age*::            <tt>integer</tt>
# *handicap*::       <tt>boolean</tt>
# *last_class*::     <tt>string</tt>
# *city*::           <tt>string</tt>
# *pole_emploi*::    <tt>boolean</tt>
# *mission_locale*:: <tt>boolean</tt>
# *cap_emploi*::     <tt>boolean</tt>
# *apec*::           <tt>boolean</tt>
# *created_at*::     <tt>datetime, not null</tt>
# *updated_at*::     <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
#
class Working < ApplicationRecord
  include Wizardable

  STEPS = %i(awareness project situation inscriptions).freeze

  with_options if: -> { required_for_step?(:awareness) } do |step|
    step.validates :awareness,
                   presence: true,
                   inclusion: { in: AWARENESSES }
  end

  with_options if: -> { required_for_step?(:project) } do |step|
    step.validates :sector,
                   presence: true,
                   inclusion: { in: SECTORS }

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

    step.validates :age, presence: true
  end
end
