class AddDefaultValueToBooleansInHousings < ActiveRecord::Migration
  def change
    change_column_default(:workings, :experience, false)
    change_column_default(:workings, :handicap, false)
    change_column_default(:workings, :pole_emploi, false)
    change_column_default(:workings, :mission_locale, false)
    change_column_default(:workings, :cap_emploi, false)
    change_column_default(:workings, :apec, false)
  end
end
