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
    @working ||= WorkingDecorator.(working_scope.find(id(:working)))
  end

  def load_housing
    @housing ||= HousingDecorator.(housing_scope.find(id(:housing)))
  end

  def load_service_offering
    @service_offering ||= ServiceOfferingDecorator.(service_offering_scope.find(id(:service_offering)))
  end

  def load_public_service
    @public_service ||= PublicServiceDecorator.(@service_offering.public_service)
  end

  def build_contact
    @contact ||= contact_scope.build
    @contact.attributes = contact_params
  end

  def contact_params
    params[:contact] ? params.require(:contact).permit(:email_or_phone) : {}
  end

  def working_scope
    Working.all
  end

  def housing_scope
    Housing.all
  end

  def service_offering_scope
    ServiceOffering.friendly.actionable
  end

  def contact_scope
    Contact.none
  end

  def id(name)
    name.to_s.pluralize == controller_name ? params[:id] : params[:"#{name}_id"]
  end
end
