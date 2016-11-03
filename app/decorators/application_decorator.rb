# encoding: utf-8
# frozen_string_literal: true

#
# Class ApplicationDecorator provides a base presenter template. It allows us
# to separate content (aka ViewModel) from template logic (as much as we can).
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class ApplicationDecorator < SimpleDelegator
  attr_reader :model

  class << self
    def call(model)
      new(model)
    end
  end

  private_class_method(:new)

  private

  def initialize(model)
    @model = model
    super
  end
end
