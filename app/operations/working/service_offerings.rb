# encoding: utf-8
# frozen_string_literal: true

class Working < ApplicationRecord
  #
  # Class Working::ServiceOfferings provides a commmand for scoping {ServiceOffering}s
  # to a {Working}'s predefined criterias.
  #
  # @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
  #
  class ServiceOfferings < Trailblazer::Operation
    include Collection
    include Matchable

    #
    # @see {Trailblazer::Operation::Model::DSL.model}
    #
    alias_method :scope, :model

    #
    # @return [String] The base path to a {Working}'s {ServiceOffering} matching.
    #
    CRITERIAS_PATH = -> { "config/criterias/#{ENV['RHIZOME']}/working.service_offerings.yml" }

    #
    # @see {Trailblazer::Operation::Resolver::BuildOperation.build_operation}
    #
    def initialize(params, _)
      @project   = Working.find(params[:id])
      @criterias = YAML.load(File.read(Rails.root.join(CRITERIAS_PATH.())))
      super
    end

    #
    # @see {Trailblazer::Operation::Collection.present}
    #
    def model!(_)
      call
    end
  end
end
