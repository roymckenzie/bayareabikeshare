class CreateBartStations < ActiveRecord::Migration
  def change
    create_table :bart_stations do |t|
      t.string :name
      t.string :id_abbr
      t.string :abbr
      t.float :lat
      t.float :lon
      t.string :address
      t.string :city
      t.string :county
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
