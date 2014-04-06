class Station < ActiveRecord::Base
  has_many :start_trips, :class_name => 'Trip', :foreign_key => 'start_station_id'
  has_many :end_trips, :class_name => 'Trip', :foreign_key => 'end_station_id'
end
