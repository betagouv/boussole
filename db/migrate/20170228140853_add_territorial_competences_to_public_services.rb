class AddTerritorialCompetencesToPublicServices < ActiveRecord::Migration
  def change
    add_column :public_services, :territorial_competences, :string, array: true, default: []
  end
end
