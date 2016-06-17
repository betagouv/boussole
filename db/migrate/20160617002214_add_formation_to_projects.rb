class AddFormationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :formation, :string
  end
end
