# encoding: utf-8
# frozen_string_literal: true

# TODO: Refacto to use {ControllerHelpers}
module Agents
  class MeasuresController < ApplicationController
    before_action :set_measure, only: %i(show edit update destroy)

    # GET /agents/measures
    def index
      @measures = Measure.all.order(:title)
    end

    # GET /agents/measures/1
    def show
    end

    # GET /agents/measures/new
    def new
      @measure = Measure.new
    end

    # GET /agents/measures/1/edit
    def edit
    end

    # POST /agents/measures
    def create
      @measure = Measure.new(measure_params)

      if @measure.save
        redirect_to(
          agents_measure_url(@measure),
          notice: t(:create, scope: 'actioncontroller.notice', model: Measure.model_name.human)
        )
      else
        render(:new)
      end
    end

    # PATCH/PUT /agents/measures/1
    def update
      if @measure.update(measure_params)
        redirect_to(
          agents_measure_url(@measure),
          notice: t(:update, scope: 'actioncontroller.notice', model: Measure.model_name.human)
        )
      else
        render(:edit)
      end
    end

    # DELETE /agents/measures/1
    def destroy
      @measure.destroy
      redirect_to(
        agents_measures_url,
        notice: t(:destroy, scope: 'actioncontroller.notice', model: Measure.model_name.human)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_measure
      @measure = measure_scope.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def measure_params
      params
        .require(:measure)
        .permit(:id, :public_service_id, :title, :description, :url, social_right_ids: [])
    end

    def measure_scope
      Measure
    end
  end
end
