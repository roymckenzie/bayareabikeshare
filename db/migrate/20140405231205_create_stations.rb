class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.integer :dockcount
      t.string :landmark
      t.date :installation
    end
  end
end
