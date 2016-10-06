class RemoveExternalFromServiceOfferings < ActiveRecord::Migration
  def change
    remove_column :service_offerings, :external, :boolean
  end
end
