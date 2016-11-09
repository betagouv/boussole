# encoding: utf-8
# frozen_string_literal: true

#
# Class WorkingDecorator provides a presenter for {PublicService}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class PublicServiceDecorator < ApplicationDecorator
  include Trackable
end
