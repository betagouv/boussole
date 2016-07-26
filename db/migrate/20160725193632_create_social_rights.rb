class CreateSocialRights < ActiveRecord::Migration
  def change
    create_table :social_rights do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps null: false
    end

    add_index :social_rights, :slug, unique: true
  end
end
