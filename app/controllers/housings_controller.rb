# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

  # GET /projects/1
  def show
    @housing = Housing.find(params[:id])

    public_services = YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['public_services']
    mesures         = YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['mesures']

    @results = { public_services: [], mesures: [] }

    @results[:public_services] << public_services['siao']          if @housing.siao?
    @results[:public_services] << public_services['crous']         if @housing.crous?
    @results[:public_services] << public_services['pain_d_avoine'] if @housing.pain_d_avoine?

    @results[:mesures] << mesures['cent_quinze'] if @housing.cent_quinze?
    @results[:mesures] << mesures['apl']         if @housing.apl?
    @results[:mesures] << mesures['cle']         if @housing.cle?
    @results[:mesures] << mesures['locapass']    if @housing.locapass?
    @results[:mesures] << mesures['visale']      if @housing.visale?
  end

  # POST /projects
  def create
    @housing = Housing.new
    @housing.save(validate: false)
    redirect_to(housing_step_path(@housing, Housing::STEPS.first))
  end
end
