# encoding: utf-8
# frozen_string_literal: true

#
# Class Feature provides feature flips/toggles.
#
# @see http://martinfowler.com/articles/feature-toggles.html
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: features
#
# *id*::         <tt>integer, not null, primary key</tt>
# *key*::        <tt>string, not null</tt>
# *enabled*::    <tt>boolean, default(FALSE), not null</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
#
class Feature < ApplicationRecord
  extend Flip::Declarable

  strategy Flip::CookieStrategy
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
          default: false,
          description: 'Housing scenarios.'

  feature :healthcaring,
          default: false,
          description: 'Healthcaring scenarios.'

  feature :talk_to_a_human,
          default: proc { rand(2).zero? },
          description: 'People would rather want to talk to a human.'
end
