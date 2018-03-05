class AddLatitudeAndLongitudeToFoundation < ActiveRecord::Migration[5.1]
  def change
    add_column :foundations, :latitude, :float
    add_column :foundations, :longitude, :float
  end
end
