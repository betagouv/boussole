class CreateServiceOfferings < ActiveRecord::Migration
  def change
    create_table :service_offerings do |t|
      t.string :title
      t.string :description
      t.references :public_service, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
