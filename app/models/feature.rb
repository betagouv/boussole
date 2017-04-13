# encoding: utf-8
# frozen_string_literal: true

#
# Class Feature provides feature flips/toggles.
#
# @see http://martinfowler.com/articles/feature-toggles.html
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class Feature < ApplicationRecord
  extend Flip::Declarable

  strategy Flip::CookieStrategy
  strategy Flip::DatabaseStrategy
  strategy Flip::DeclarationStrategy
  default false

  feature :talk_to_a_human,
          default: proc { rand(2).zero? },
          description: 'People would rather want to talk to a human.'
end
