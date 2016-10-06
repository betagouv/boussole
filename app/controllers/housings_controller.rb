# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

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
end
