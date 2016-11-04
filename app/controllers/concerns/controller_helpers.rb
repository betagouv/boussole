# encoding: utf-8
# frozen_string_literal: true

#
# Module ControllerHelpers provides a mixin to get loading, building, scopes
# and decorations across controllers.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module ControllerHelpers
  extend ActiveSupport::Concern

  private

  def load_working
    @working ||= working_scope.find(id(:working))
  end

  def load_service_offering
    @service_offering ||= service_offering_scope.find(id(:service_offering))
  end

  def decorate_service_offering!
    @service_offering = ServiceOfferingDecorator.(@service_offering)
  end

  def build_contact
    @contact ||= contact_scope.build
    @contact.attributes = contact_params
  end

  def working_scope
    Working.all
  end

  def service_offering_scope
    ServiceOffering.friendly
  end

  def contact_scope
    Contact.none
  end

  def id(name)
    name.to_s.pluralize == controller_name ? params[:id] : params[:"#{name}_id"]
  end
end
