# encoding: utf-8
# frozen_string_literal: true
# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  key        :string           not null
#  enabled    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
