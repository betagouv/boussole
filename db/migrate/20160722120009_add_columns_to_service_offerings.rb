class AddColumnsToServiceOfferings < ActiveRecord::Migration
  def change
    add_column :service_offerings, :postal_address, :string
    add_column :service_offerings, :email, :string
    add_column :service_offerings, :phone, :string
    add_column :service_offerings, :url, :string
    add_column :service_offerings, :external, :boolean
  end
end
