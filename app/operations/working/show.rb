# encoding: utf-8
# frozen_string_literal: true

class Working < ApplicationRecord
  #
  # Class Working::Find provides a commmand for finding a {Working}.
  #
  # @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
  #
  class Show < Trailblazer::Operation
    include Model
    model Working, :find

    #
    # @see https://github.com/apotonick/trailblazer/issues/137
    #
    def process(params); end
  end
end
