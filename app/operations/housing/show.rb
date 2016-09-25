# encoding: utf-8
# frozen_string_literal: true

class Housing < ApplicationRecord
  #
  # Class Housing::Find provides a commmand for finding a {Housing}.
  #
  # @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
  #
  class Show < Trailblazer::Operation
    include Model
    model Housing, :find

    #
    # @see https://github.com/apotonick/trailblazer/issues/137
    #
    def process(params); end
  end
end
