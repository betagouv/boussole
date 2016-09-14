class AddSlugToPublicServices < ActiveRecord::Migration
  def change
    add_column :public_services, :slug, :string
    add_index  :public_services, :slug, unique: true
  end
end
