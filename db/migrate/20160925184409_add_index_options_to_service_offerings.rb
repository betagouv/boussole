class AddIndexOptionsToServiceOfferings < ActiveRecord::Migration
  def change
    remove_index  :service_offerings, %i(public_service_id slug)
    add_index :service_offerings, %i(public_service_id slug), unique: true
  end
end
