# encoding: utf-8
# frozen_string_literal: true

#
# Class WorkingDecorator provides a presenter for {Working}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class WorkingDecorator < ApplicationDecorator
  include Trackable
  include Emailable
end
