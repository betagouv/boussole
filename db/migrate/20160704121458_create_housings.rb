class CreateHousings < ActiveRecord::Migration
  def change
    create_table :housings do |t|

      t.timestamps null: false
    end
  end
end
