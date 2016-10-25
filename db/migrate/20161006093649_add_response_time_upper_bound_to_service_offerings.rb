class AddResponseTimeUpperBoundToServiceOfferings < ActiveRecord::Migration
  def change
    add_column(:service_offerings, :response_time_upper_bound, :integer)
    add_index(:service_offerings, :response_time_upper_bound)
  end
end
