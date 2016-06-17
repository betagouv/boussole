class AddDomainToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :domain, :string
  end
end
