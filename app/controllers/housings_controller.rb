# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

  # Tracking
  after_action :track_starts_form, only: :create, unless: :blacklisted_ips?
  after_action :track_finishes_form, only: :show, unless: :blacklisted_ips?

  # GET /projects/1
  def show
    @housing           = Housing.find(params[:id])
    @service_offerings = Housing::ServiceOfferings.present(params).scope
  end

  # POST /projects
  def create
    @housing = Housing.new
    @housing.save(validate: false)
    redirect_to(housing_step_path(@housing, Housing::STEPS.first))
  end

  private

  def track_starts_form
    tracker.(:jeunes, :starts_form, housing_id: @housing.to_param)
  end

  def track_finishes_form
    tracker.(:jeunes, :finishes_form, housing: HousingDecorator.(@housing), servive_offering_count: @service_offerings.count)
  end
end
