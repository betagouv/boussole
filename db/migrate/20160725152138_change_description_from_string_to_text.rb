class ChangeDescriptionFromStringToText < ActiveRecord::Migration
  def change
    change_column :service_offerings, :description, :text
    change_column :measures,          :description, :text
  end
end
