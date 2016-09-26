# encoding: utf-8
# frozen_string_literal: true

#
# Module Wizardable provides a mixin to turn a model into a persistanceless state machine.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Wizardable
  extend ActiveSupport::Concern

  included do
    #
    # @!attribute [rw] current_step
    # @return [Symbol] Current state in the project construction.
    #
    attr_accessor :current_step
  end

  private

  # TODO: Document.
  def required_for_step?(step)
    return true if step.nil?
    return true if current_step.nil?
    return true if self.class::STEPS.index(step.to_sym) <= self.class::STEPS.index(current_step)
  end
end
