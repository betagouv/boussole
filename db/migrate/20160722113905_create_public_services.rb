class CreatePublicServices < ActiveRecord::Migration
  def change
    create_table :public_services do |t|
      t.string :title
      t.text :description
      t.string :postal_address
      t.string :email
      t.string :phone
      t.string :url

      t.timestamps null: false
    end
  end
end
