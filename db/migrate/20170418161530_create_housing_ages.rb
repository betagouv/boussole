class CreateHousingAges < ActiveRecord::Migration
  def change
    create_table :housing_ages do |t|
      t.integer :minimum
      t.integer :maximum
      t.references :target_public, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
