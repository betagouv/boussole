class AddSlugToServiceOfferings < ActiveRecord::Migration
  def change
    add_column :service_offerings, :slug, :string
    add_index  :service_offerings, %i(public_service_id slug)
  end
end
