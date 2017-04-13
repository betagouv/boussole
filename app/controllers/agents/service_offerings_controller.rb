# encoding: utf-8
# frozen_string_literal: true

module Agents
  class ServiceOfferingsController < ApplicationController
    before_action :set_service_offering, only: %i(show edit update destroy)

    # GET /agents/service_offerings
    def index
      @service_offerings = ServiceOffering.all.order(:title)
    end

    # GET /agents/service_offerings/1
    def show
    end

    # GET /agents/service_offerings/new
    def new
      @service_offering = ServiceOffering.new
    end

    # GET /agents/service_offerings/1/edit
    def edit
    end

    # POST /agents/service_offerings
    def create
      @service_offering = ServiceOffering.new(service_offering_params)

      if @service_offering.save
        redirect_to(
          agents_service_offering_url(@service_offering),
          notice: t(:create, scope: 'actioncontroller.notice', model: ServiceOffering.model_name.human)
        )
      else
        render(:new)
      end
    end

    # PATCH/PUT /agents/service_offerings/1
    def update
      if @service_offering.update(service_offering_params)
        redirect_to(
          agents_service_offering_url(@service_offering),
          notice: t(:update, scope: 'actioncontroller.notice', model: ServiceOffering.model_name.human)
        )
      else
        render(:edit)
      end
    end

    # DELETE /agents/service_offerings/1
    def destroy
      @service_offering.destroy
      redirect_to(
        agents_service_offerings_url,
        notice: t(:destroy, scope: 'actioncontroller.notice', model: ServiceOffering.model_name.human)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_service_offering
      @service_offering = service_offering_scope.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_offering_params
      params
        .require(:service_offering)
        .permit(
          :id,
          :title,
          :public_service_id,
          :description,
          :postal_address,
          :email,
          :phone,
          :url,
          :response_time_upper_bound,
          :social_right_id
        )
    end

    def service_offering_scope
      ServiceOffering.friendly
    end
  end
end
