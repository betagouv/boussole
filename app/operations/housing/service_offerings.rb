# encoding: utf-8
# frozen_string_literal: true

class Housing < ApplicationRecord
  #
  # Class Housing::ServiceOfferings provides a commmand for scoping {ServiceOffering}s
  # to a {Housing}'s predefined criterias.
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
    # @see {Trailblazer::Operation::Resolver::BuildOperation.build_operation}
    #
    def initialize(params, _)
      @project   = Housing.find(params[:id])
      @criterias = YAML.load(File.read(Rails.root.join(self.class.send(:criterias_path))))
      super
    end

    #
    # @see {Trailblazer::Operation::Collection.present}
    #
    def model!(_)
      call
    end

    class << self
      private

      #
      # @return [String] The base path to a {Housing}'s {ServiceOffering} matching.
      #
      def criterias_path
        "config/criterias/#{ENV['RHIZOME']}/housing.service_offerings.yml"
      end
    end
  end
end
