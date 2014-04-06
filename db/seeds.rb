# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# Seed Stations model
Station.delete_all

CSV.foreach("#{Rails.root}/db/seeds/stations.csv", :headers => true) do |row|
   Station.create!(row.to_hash)
end