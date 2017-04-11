class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.string :name
      t.string :operator
      t.string :value
      t.references :service_offering, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
