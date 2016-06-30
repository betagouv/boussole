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

  DISCRIMINANTS = {
    knowledge: KNOWLEDGE_QUESTIONS,
    age: AGE,
    status: STATUS,
    handicap: [true, false],
    degree: DEGREE,
    last_class: LAST_CLASS,
    intention: INTENTION,
    experience: [true, false],
    pe: [true, false],
    ml: [true, false],
    apec: [true, false],
    cap: [true, false]
  }.freeze

  DISCRIMINANTS_NOT_WORKING = {
    knowledge: KNOWLEDGE_QUESTIONS,
    experience: EXPERIENCE,
    status: [STATUS[0]],
    degree: DEGREE,
    last_class: LAST_CLASS,
    intention: INTENTION
  }.freeze

  DISCRIMINANTS_WORKING = {
    knowledge: KNOWLEDGE_QUESTIONS,
    experience: EXPERIENCE,
    status: [STATUS[3]],
    degree: DEGREE,
    last_class: LAST_CLASS,
    intention: INTENTION
  }.freeze

  def self.product_array_sample_csv(hash = DISCRIMINANTS, n: 1000)
    CSV.open('train.csv', 'wb') do |csv|
      product_array(hash)
        .sample(n)
        .prepend(DISCRIMINANTS.keys.map(&:to_s))
        .map { |row| csv << row }
    end
  end

  def self.product_array_sample(hash = DISCRIMINANTS, n: 1000)
    product_array(hash).sample(n)
  end

  def self.product_array(hash = DISCRIMINANTS)
    attrs = hash.values
    filter(attrs[0].product(*attrs[1..-1]))
  end

  def self.product_hash(hash = DISCRIMINANTS)
    product_array(hash).map { |p| Hash[hash.keys.zip p] }
  end

  def self.filter(product_array)
    # Age
    product_array.delete_if { |array| array[1] == '>30' }

    # Status
    product_array.delete_if { |array| array[2] == 'Lycéen·ne – collégien·ne' }
    product_array.delete_if { |array| array[2] == 'Autre' }

    # Degree
    # product_array.delete_if { |array| array[5] == 'BEPC' }
    # product_array.delete_if { |array| array[5] == 'CAP' }
    # product_array.delete_if { |array| array[5] == 'BEP' }
    product_array.delete_if { |array| array[5] == 'Non' }

    # Handicap / Cap emploi
    product_array.delete_if { |array| !array[3] && array[10] }
  end

  private

  def required_for_step?(step)
    return true  if step.nil?
    return false if step == :formation && awareness == AWARENESSES[1]
    return true  if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
