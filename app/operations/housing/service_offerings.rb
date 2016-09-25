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
    alias_method :scope, :model

    #
    # @return [String] The base path to a {Housing}'s {ServiceOffering} matching.
    #
    CRITERIAS_PATH = 'config/criterias/reims/housing.service_offerings.yml'

    #
    # @!attribute [r] housing
    #   @return [Housing] The {Housing} project we're matching against.
    #
    attr_reader :housing

    #
    # @!attribute [r] criterias
    #   @return [Hash] The hash of {ServiceOffering} criterias we're matching with.
    #
    attr_reader :criterias

    #
    # @see {Trailblazer::Operation::Resolver::BuildOperation.build_operation}
    #
    def initialize(housing_id, _)
      @housing   = Housing.find(housing_id)
      @criterias = YAML.load(File.read(Rails.root.join(CRITERIAS_PATH)))
      super
    end

    #
    # Search for {ServiceOffering}s matching the current housing project with a set of
    # predefined rules.
    #
    # @see {Trailblazer::Operation::Collection.present}
    # @note It does not scope results to corresponding {PublicService}
    #
    # @example
    #
    #   Housing::ServiceOfferings.present(1)
    #   #=> #<ActiveRecord::Relation [#<ServiceOffering id: 1 ...>]>
    #
    # @return [ActiveRecord::Relation<ServiceOffering>] The matched records.
    #
    def model!(_)
      with_matches do |matches|
        ServiceOffering.where(slug: matches)
      end
    end

    private

    def with_matches(&_)
      # TODO: Build query with Arel so to match public services as well
      # TODO: Document
      matches = criterias.each_with_object([]) do |(_, service_offerings), slugs|
        service_offerings.each do |service_offering, scenarios|
          scenarios.each do |scenario|
            slugs << service_offering if match_scenario?(scenario)
          end
        end
      end

      yield(matches)
    end

    #
    # Given an {Array} of conditions, it loops through it to check whether each condition is satisfied. As soon as one
    # condition doesn't, it breaks from the loop.
    #
    # @param [Array] conditions The conditions to check against the {Housing}.
    #
    # @example
    #
    #   housing.resources
    #   #=> 150
    #
    #   conditions = [{ "attribute" => "resources", "operator" => ">=", "value" => 150 }]
    #   match_conditions?(conditions)
    #   #=> true
    #
    # @return [Boolean] True if all conditions are met.
    # @return [Boolean] False unless all conditions are met.
    #
    def match_conditions?(conditions)
      conditions.inject(true) do |result, condition|
        break(result) unless result

        result &&
          housing
            .public_send(condition['attribute'])
            .public_send(condition['operator'], condition['value'])
      end
    end
  end
end
