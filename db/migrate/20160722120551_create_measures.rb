class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :title
      t.string :description
      t.string :url
      t.references :public_service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
