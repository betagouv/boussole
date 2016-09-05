# encoding: utf-8
# frozen_string_literal: true

module Agents
  class PublicServicesController < ApplicationController
    before_action :set_public_service, only: %i(show edit update destroy)

    # GET /agents/public_services
    def index
      @public_services = PublicService.all.order(:title)
    end

    # GET /agents/public_services/1
    def show
    end

    # GET /agents/public_services/new
    def new
      @public_service = PublicService.new
    end

    # GET /agents/public_services/1/edit
    def edit
    end

    # POST /agents/public_services
    def create
      @public_service = PublicService.new(public_service_params)

      if @public_service.save
        redirect_to(
          agents_public_service_url(@public_service),
          notice: t(:notice, scope: 'agents.public_services.create')
        )
      else
        render(:new)
      end
    end

    # PATCH/PUT /agents/public_services/1
    def update
      if @public_service.update(public_service_params)
        redirect_to(
          agents_public_service_url(@public_service),
          notice: t(:notice, scope: 'agents.public_services.update')
        )
      else
        render(:edit)
      end
    end

    # DELETE /agents/public_services/1
    def destroy
      @public_service.destroy
      redirect_to(
        agents_public_services_url,
        notice: t(:notice, scope: 'agents.public_services.destroy')
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_public_service
      @public_service = public_service_scope.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def public_service_params
      params
        .require(:public_service)
        .permit(
          id: Parameters.id,
          title: Parameters.string,
          description: Parameters.string,
          postal_address: Parameters.string,
          email: Parameters.string,
          phone: Parameters.string,
          url: Parameters.string,
          social_right_ids: Parameters.array(Parameters.string)
        )
    end

    def public_service_scope
      PublicService
    end
  end
end
