# encoding: utf-8
# frozen_string_literal: true

class WorkingsController < ApplicationController
  require_feature :working

  # GET /workings/1
  def show
    @working           = Working.find(params[:id])
    @service_offerings = Working::ServiceOfferings.present(params).scope
  end

  # POST /workings
  def create
    @working = Working.new
    @working.save(validate: false)
    redirect_to(working_step_path(@working, Working::STEPS.first))
  end
end
