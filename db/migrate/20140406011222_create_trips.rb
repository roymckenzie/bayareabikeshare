class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :duration
      t.datetime :start_date
      t.references :start_station, index: true
      t.datetime :end_date
      t.references :end_station, index: true
      t.integer :bike_id
      t.boolean :subscription
      t.string :zip
    end
  end
end
