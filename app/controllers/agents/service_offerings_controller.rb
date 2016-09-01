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
        redirect_to(agents_service_offering_url(@service_offering), notice: t('.notice'))
      else
        render(:new)
      end
    end

    # PATCH/PUT /agents/service_offerings/1
    def update
      if @service_offering.update(service_offering_params)
        redirect_to(agents_service_offering_url(@service_offering), notice: t('.notice'))
      else
        render(:edit)
      end
    end

    # DELETE /agents/service_offerings/1
    def destroy
      @service_offering.destroy
      redirect_to(agents_service_offerings_url, notice: t('.notice'))
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_service_offering
      @service_offering = ServiceOffering.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_offering_params
      params
        .require(:service_offering)
        .permit(
          id: Parameters.id,
          public_service_id: Parameters.id,
          title: Parameters.string,
          description: Parameters.string,
          postal_address: Parameters.string,
          email: Parameters.string,
          phone: Parameters.string,
          url: Parameters.string,
          external: Parameters.boolean,
          social_right_ids: Parameters.array(Parameters.string)
        )
    end
  end
end
