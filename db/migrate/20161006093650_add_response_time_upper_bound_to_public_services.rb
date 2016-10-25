class AddResponseTimeUpperBoundToPublicServices < ActiveRecord::Migration
  def change
    add_column(:public_services, :response_time_upper_bound, :integer)
    add_index(:public_services, :response_time_upper_bound)
  end
end
