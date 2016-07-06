# encoding: utf-8
# frozen_string_literal: true

class HousingsController < ApplicationController
  require_feature :housing

  # GET /projects/1
  def show
    @housing = Housing.find(params[:id])

    @results = { a: [], b: [] }

    @results[:a] << 'SIAO'          if @housing.siao?
    @results[:a] << 'Crous'         if @housing.crous?
    @results[:a] << "Pain d'avoine" if @housing.pain_d_avoine?
    @results[:b] << '115'           if @housing.cent_quinze?
    @results[:b] << 'APL'           if @housing.apl?
    @results[:b] << 'CLE'           if @housing.cle?
    @results[:b] << 'Locapass'      if @housing.locapass?
    @results[:b] << 'Visale'        if @housing.visale?
  end

  # POST /projects
  def create
    @housing = Housing.new
    @housing.save(validate: false)
    redirect_to(housing_step_path(@housing, Housing::STEPS.first))
  end
end
