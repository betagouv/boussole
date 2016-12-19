# encoding: utf-8
# frozen_string_literal: true

#
# Class HousingDecorator provides a presenter for {Housing}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class HousingDecorator < ApplicationDecorator
  include Trackable
  include Emailable

  #
  # Alias for {#current_status}.
  #
  def status
    model.current_status
  end
end
