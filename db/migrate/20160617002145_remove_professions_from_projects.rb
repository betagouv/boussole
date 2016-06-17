class RemoveProfessionsFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :profession, :string
  end
end
