class CreateCaltrainStations < ActiveRecord::Migration
  def change
    create_table :caltrain_stations do |t|
      t.name :string
      t.float :lat
      t.float :lon
    end
  end
end
