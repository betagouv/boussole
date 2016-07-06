# encoding: utf-8
# frozen_string_literal: true

class Feature < ActiveRecord::Base
  extend Flip::Declarable

  strategy Flip::DatabaseStrategy
  strategy Flip::DeclarationStrategy
  default false

  feature :working,
          default: false,
          description: 'Working scenarios.'

  feature :training,
          default: false,
          description: 'Training scenarios.'

  feature :housing,
          default: true,
          description: 'Housing scenarios.'

  feature :traveling,
          default: false,
          description: 'Traveling scenarios.'

  feature :healthcaring,
          default: false,
          description: 'Healthcaring scenarios.'
end
