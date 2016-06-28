class AddDegreeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :degree, :string
  end
end
