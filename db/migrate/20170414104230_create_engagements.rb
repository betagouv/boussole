class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps null: false
    end
  end
end
