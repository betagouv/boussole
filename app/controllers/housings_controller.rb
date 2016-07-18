# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

  # GET /projects/1
  # TODO: Refacto (or get rid of).
  def show
    @housing = Housing.find(params[:id])
    @results = []

    load_results_for_siao
    load_results_for_crous
    load_results_for_paindavoine
    load_results_for_action_logement
    load_results_for_caf
  end

  # POST /projects
  def create
    @housing = Housing.new
    @housing.save(validate: false)
    redirect_to(housing_step_path(@housing, Housing::STEPS.first))
  end

  private

  def load_results_for_siao
    if @housing.siao? || @housing.cent_quinze?
      public_services['siao'][:mesures] = []
      public_services['siao'][:mesures] << mesures['cent_quinze'] if @housing.cent_quinze?
      @results << public_services['siao']
    end
  end

  def load_results_for_crous
    if @housing.crous? || @housing.cle?
      public_services['crous'][:mesures] = []
      public_services['crous'][:mesures] << mesures['cle'] if @housing.cle?
      @results << public_services['crous']
    end
  end

  def load_results_for_paindavoine
    if @housing.paindavoine?
      public_services['paindavoine'][:mesures] = []
      @results << public_services['paindavoine']
    end
  end

  def load_results_for_action_logement
    if @housing.locapass? || @housing.visale?
      public_services['action_logement'][:mesures] = []
      public_services['action_logement'][:mesures] << mesures['locapass'] if @housing.locapass?
      public_services['action_logement'][:mesures] << mesures['visale']   if @housing.visale?
      @results << public_services['action_logement']
    end
  end

  def load_results_for_caf
    if @housing.apl?
      public_services['caf'][:mesures] = []
      public_services['caf'][:mesures] << mesures['apl']
      @results << public_services['caf']
    end
  end

  def public_services
    @public_services ||= YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['public_services']
  end

  def mesures
    @mesures = YAML.load(File.read(Rails.root.join('config', 'parameters.yml')))['mesures']
  end
end
