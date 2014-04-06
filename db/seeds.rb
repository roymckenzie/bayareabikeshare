# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# Seed Station model
Station.delete_all
CSV.foreach("#{Rails.root}/db/seeds/stations.csv", :headers => true) do |row|
   Station.create!(row.to_hash)
end

# Seed Trip model
Trip.delete_all
CSV.foreach("#{Rails.root}/db/seeds/trips.csv", :headers => true) do |row|
  Trip.create!({
    :id => row[0],
    :duration => row[1],
    :start_date => (DateTime.strptime row[2], "%m/%d/%Y %H:%M"), 
    :start_station => Station.find(row[3]),
    :end_date => (DateTime.strptime row[5], "%m/%d/%Y %H:%M"), 
    :end_station => Station.find(row[6]), 
    :bike_id => row[8], 
    :subscription => row[9], 
    :zip => row[10],
  })
end