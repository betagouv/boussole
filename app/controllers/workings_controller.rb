# encoding: utf-8
# frozen_string_literal: true

class WorkingsController < ApplicationController
  include ControllerHelpers

  # Tracking
  after_action :track_starts_form, only: :create, if: :trackable?
  after_action :track_finishes_form, only: :show, if: :trackable?

  # GET /workings/1
  def show
    load_working
    @service_offerings = Working::ServiceOfferings.present(params).scope
  end

  # POST /workings
  def create
    build_working
    @working.save(validate: false)
    redirect_to(working_step_path(@working, Working::STEPS.first))
  end

  private

  def track_starts_form
    tracker.(:jeunes, :starts_form, working_id: @working.to_param)
  end

  def track_finishes_form
    tracker.(:jeunes, :finishes_form, working: WorkingDecorator.(@working), servive_offering_count: @service_offerings.count)
  end
end
