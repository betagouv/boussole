# encoding: utf-8
# frozen_string_literal: true

#
# Class Training provides the representation of a training project/need and its corresponding discriminant criterias.
# Discriminant criterias are those determining the applicability of services to target audiences.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
# TODO: Rename to {Training}
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: projects
#
# *id*::         <tt>integer, not null, primary key</tt>
# *knowledge*::  <tt>string</tt>
# *age*::        <tt>integer</tt>
# *status*::     <tt>string</tt>
# *last_class*:: <tt>string</tt>
# *city*::       <tt>string</tt>
# *handicap*::   <tt>boolean</tt>
# *experience*:: <tt>boolean</tt>
# *pe*::         <tt>boolean</tt>
# *ml*::         <tt>boolean</tt>
# *cap*::        <tt>boolean</tt>
# *apec*::       <tt>boolean</tt>
# *area*::       <tt>string</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *domain*::     <tt>string</tt>
# *formation*::  <tt>string</tt>
# *degree*::     <tt>string</tt>
# *intention*::  <tt>boolean</tt>
#--
# == Schema Information End
#++
#
class Project < ApplicationRecord
  include Wizardable

  STEPS = %i(awareness formation profile inscriptions).freeze

  with_options if: -> { required_for_step?(:knowledge) } do |step|
    step.validates :awareness, presence: true
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
    return true  if step.nil?
    return false if step == :formation && awareness == AWARENESSES[1]
    return true  if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
