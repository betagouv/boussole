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
    knowledge: [true, false],
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

  def self.scenarios_array_csv
    CSV.open('train.csv', 'wb') do |csv|
      scenarios_array.map { |row| csv << row }
    end
  end

  def self.scenarios_array
    filter(
      scenario_1 +
        scenario_1_bis +
        scenario_2 +
        scenario_2_bis +
        scenario_3 +
        scenario_3_bis +
        scenario_4_bis +
        scenario_5 +
        scenario_6 +
        scenario_6_bis
    )
  end

  def self.scenario_1
    scenario_builder(
      knowledges:     [false],
      ages:           ['[16-26)'],
      statuses:       ['Salarié·e'],
      handicaps:      [false],
      intentions:     [true, false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [false],
      pes:            [false],
      mls:            [false],
      apecs:          [false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  true,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   true,
      fongecif:       true,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            true
    )
  end

  def self.scenario_1_bis
    scenario_builder(
      knowledges:     [false],
      ages:           ['[16-26)'],
      statuses:       ['Sans activité'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [false],
      pes:            [false],
      mls:            [false],
      apecs:          [false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  true,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   true,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_2
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)', '[16-30]', '[26-30]'],
      statuses:       ['Sans activité', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [true],
      intentions:     [true, false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [true, false],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [false],
      caps:           [true, false],
      mission_locale: false,
      espace_metier:  false,
      cap_emploi:     true,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_2_bis
    scenario_builder(
      knowledges:     [false],
      ages:           ['[16-26)', '[16-30]', '[26-30]'],
      statuses:       ['Sans activité', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [true],
      intentions:     [true, false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [true, false],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [false],
      caps:           [true, false],
      mission_locale: false,
      espace_metier:  true,
      cap_emploi:     true,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   true,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_3
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)'],
      statuses:       ['Sans activité'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [false],
      pes:            [false],
      mls:            [false],
      apecs:          [false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  true,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   true,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_3_bis
    scenario_builder(
      knowledges:     [true, false],
      ages:           ['[16-26)'],
      statuses:       ['Lycéen·ne – collégien·ne'],
      handicaps:      [false],
      intentions:     [true],
      degrees:        ['Non'],
      experiences:    [false],
      pes:            [false],
      mls:            [false],
      apecs:          [false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  false,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   true,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            true,
      cfa:            false
    )
  end

  def self.scenario_4
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)'],
      statuses:       ['Sans activité', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BEPC', 'CAP', 'BEP', 'Non'],
      experiences:    [true],
      pes:            [false],
      mls:            [true, false],
      apecs:          [false],
      caps:           [false],
      mission_locale: true,
      espace_metier:  false,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           false,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_4_bis
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)'],
      statuses:       ['Sans activité', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BAC'],
      experiences:    [true],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [false],
      caps:           [false],
      mission_locale: true,
      espace_metier:  false,
      cap_emploi:     false,
      pole_emploi:    true,
      apec:           false,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_5
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)', '[16-30]', '[26-30]'],
      statuses:       ['Étudiant·e'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BAC'],
      experiences:    [true, false],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  false,
      cap_emploi:     false,
      pole_emploi:    true,
      apec:           false,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      true,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_6
    scenario_builder(
      knowledges:     [true],
      ages:           ['[16-26)', '[16-30]', '[26-30]'],
      statuses:       ['Sans activité', 'Étudiant·e', 'Lycéen·ne – collégien·ne', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['Bac +3'],
      experiences:    [true, false],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [true, false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  false,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           true,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_6_bis
    scenario_builder(
      knowledges:     [false],
      ages:           ['[16-26)', '[16-30]', '[26-30]'],
      statuses:       ['Sans activité', 'Étudiant·e', 'Salarié·e', 'Stagiaire – En formation', 'Apprenti·e'],
      handicaps:      [false],
      intentions:     [false],
      degrees:        ['BAC', 'Bac +3'],
      experiences:    [true, false],
      pes:            [true, false],
      mls:            [true, false],
      apecs:          [true, false],
      caps:           [false],
      mission_locale: false,
      espace_metier:  true,
      cap_emploi:     false,
      pole_emploi:    false,
      apec:           true,
      crij_bij_pij:   false,
      fongecif:       false,
      opacif:         false,
      siou_baip:      false,
      cio:            false,
      cfa:            false
    )
  end

  def self.scenario_builder(knowledges:, ages:, statuses:, handicaps:, intentions:, degrees:, experiences:, pes:, mls:, apecs:, caps:, mission_locale:, espace_metier:, cap_emploi:,  pole_emploi:, apec:,  crij_bij_pij:,  fongecif:,  opacif:,  siou_baip:, cio:, cfa:)
    array = []

    knowledges.each do |knowledge|
      ages.each do |age|
        statuses.each do |status|
          handicaps.each do |handicap|
            intentions.each do |intention|
              degrees.each do |degree|
                experiences.each do |experience|
                  pes.each do |pe|
                    mls.each do |ml|
                      apecs.each do |apec|
                        caps.each do |cap|
                          array << [
                            knowledge,
                            age,
                            status,
                            handicap,
                            intention,
                            degree,
                            experience,
                            pe,
                            ml,
                            apec,
                            cap,
                            mission_locale,
                            espace_metier,
                            cap_emploi,
                            pole_emploi,
                            apec,
                            crij_bij_pij,
                            fongecif,
                            opacif,
                            siou_baip,
                            cio,
                            cfa
                          ]
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    array
  end

  private

  def required_for_step?(step)
    return true  if step.nil?
    return false if step == :formation && awareness == AWARENESSES[1]
    return true  if STEPS.index(step.to_sym) <= STEPS.index(current_step)
  end
end
