class AddCodeToServiceOfferings < ActiveRecord::Migration
  def change
    add_column :service_offerings, :code, :string

    add_index :service_offerings, :code
  end
end
