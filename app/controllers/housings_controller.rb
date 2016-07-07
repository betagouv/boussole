# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

  # GET /projects/1
  def show
    @housing = Housing.find(params[:id])

    public_services = YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['public_services']
    mesures         = YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['mesures']

    @results = []

    # SIAO
    if @housing.siao? || @housing.cent_quinze?
      public_services['siao'][:mesures] = []
      public_services['siao'][:mesures] << mesures['cent_quinze'] if @housing.cent_quinze?
      @results << public_services['siao']
    end

    # Crous
    if @housing.crous? || @housing.cle?
      public_services['crous'][:mesures] = []
      public_services['crous'][:mesures] << mesures['cle'] if @housing.cle?
      @results << public_services['crous']
    end

    # Paindavoine
    if @housing.pain_d_avoine?
      public_services['pain_d_avoine'][:mesures] = []
      @results << public_services['pain_d_avoine']
    end

    if @housing.locapass? || @housing.visale?
      public_services['action_logement'][:mesures] = []
      public_services['action_logement'][:mesures] << mesures['locapass'] if @housing.locapass?
      public_services['action_logement'][:mesures] << mesures['visale']   if @housing.visale?
      @results << public_services['action_logement']
    end

    # CAF
    # if @housing.apl?
    #   public_services['caf'][:mesures] = [mesures['apl']]
    #   @results << public_services['caf']
    # end
  end

  # POST /projects
  def create
    @housing = Housing.new
    @housing.save(validate: false)
    redirect_to(housing_step_path(@housing, Housing::STEPS.first))
  end
end
