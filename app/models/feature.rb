# encoding: utf-8
# frozen_string_literal: true

#
# TODO: Add documentation.
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
