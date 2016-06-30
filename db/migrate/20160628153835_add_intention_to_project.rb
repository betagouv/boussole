class AddIntentionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :intention, :boolean
  end
end
