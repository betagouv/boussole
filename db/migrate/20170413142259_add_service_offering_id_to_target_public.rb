class AddServiceOfferingIdToTargetPublic < ActiveRecord::Migration
  def change
    add_reference :target_publics, :service_offering
  end
end
