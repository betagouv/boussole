# encoding: utf-8
# frozen_string_literal: true

#
# Module Matchable provides a mixin to implement a matching commmand.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Matchable
  extend ActiveSupport::Concern
  #
  # @!attribute [r] project
  #
  # @return The project we're matching against.
  #
  attr_reader :project

  #
  # @!attribute [r] criterias
  #
  # @return [Hash] The hash of {ServiceOffering} criterias we're matching with.
  #
  attr_reader :criterias

  #
  # Search for {ServiceOffering}s matching the current project with a set of
  # predefined rules.
  #
  # @example
  #
  #   SomeClass.new(@project).call
  #   #=> #<ActiveRecord::Relation [#<ServiceOffering id: 1 ...>]>
  #
  # @return [ActiveRecord::Relation<ServiceOffering>] The matched records.
  #
  def call
    with_matches do |service_offerings, public_services|
      return ServiceOffering.none unless service_offerings.any?

      with_predicate(service_offerings, public_services) do |predicate|
        ServiceOffering
          .actionable
          .joins(:public_service)
          .where(predicate)
      end
    end
  end

  private

  #
  # Given a {Hash} of criterias, the method will build an {Array} of the satisfying {ServiceOffering} matches
  # of the project.
  #
  # @example
  #
  #   with_matches do |service_offerings, public_services|
  #     puts service_offerings
  #     puts public_services
  #   end
  #
  #   #=> ['some-service-offering']
  #   #=> ['some-public-service']
  #
  # @yieldparam [Array] service_offerings {ServiceOffering}'s {Array} of slugs.
  # @yieldparam [Array] public_services {PublicService}'s {Array} of slugs.
  #
  def with_matches(&_)
    service_offerings, public_services =
      criterias.each_with_object([[], []]) do |(public_service, service_offerings), matches|
        service_offerings.each do |service_offering, scenarios|
          scenarios.each do |conditions|
            if match_conditions?(conditions)
              matches[0] << service_offering
              matches[1] << public_service
            end
          end
        end
      end

    yield(service_offerings, public_services)
  end

  #
  # Given an {Array} of {ServiceOffering} slugs and one of its corresponding {PublicService} ones,
  # the method will build an {Arel} predicate to be passed on to a {ActiveRecord::Base.where} clause.
  #
  # @param [Array] service_offerings {ServiceOffering}'s {Array} of slugs.
  # @param [Array] public_services {PublicService}'s {Array} of slugs.
  #
  # @yieldreturn [Arel::Node::Equality] If there's only one slug to match.
  # @yieldreturn [Arel::Node::Grouping] If there're many slugs to match.
  #
  def with_predicate(service_offerings, public_services, &_)
    predicate =
      service_offerings
      .each_with_index
      .inject(predicate_builder(service_offerings[0], public_services[0])) do |node, (service_offering, index)|
        next(node) if index.zero?

        node.or(predicate_builder(service_offering, public_services[index]))
      end

    yield(predicate)
  end

  #
  # Loops through a given {Array} of conditions, to check whether each of latter is satisfied. As soon as one
  # doesn't it breaks from the loop.
  #
  # @param [Array] conditions The conditions to check against.
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
        project
          .public_send(condition['attribute'])
          .public_send(condition['operator'], condition['value'])
    end
  end

  #
  # Creates an {Arel::Node::Equality} predicate instance to be passed on as an argument
  # to a {ActiveRecord::Base.where} clause.
  #
  # @param [<String>] service_offering {ServiceOffering}'s slug.
  # @param [<String>] public_service {PublicService}'s slug.
  #
  # @return [Arel::Node::Equality] The predicate.
  #
  def predicate_builder(service_offering, public_service)
    service_offering_table[:slug]
      .eq(service_offering)
      .and(public_service_table[:slug].eq(public_service))
  end

  #
  # Creates a {ServiceOffering} {Arel::Table} instance.
  #
  # @return [Arel::Table] The {Arel::Table} instance.
  #
  def service_offering_table
    @service_offering_table ||= ServiceOffering.arel_table
  end

  #
  # Creates a {PublicService} {Arel::Table} instance.
  #
  # @return [Arel::Table] The {Arel::Table} instance.
  #
  def public_service_table
    @public_service_table ||= PublicService.arel_table
  end
end
