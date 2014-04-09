class CreateCaltrainStations < ActiveRecord::Migration
  def change
    create_table :caltrain_stations do |t|
      t.string :name
      t.string :city
      t.float :lat
      t.float :lon
    end
  end
end
