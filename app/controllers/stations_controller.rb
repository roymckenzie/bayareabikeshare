class StationsController < ApplicationController
  def index

    @stations = Station.all

    #Get an array of coordinates for map
    @station_coordinates = Array.new
    @stations.each do |s|
      @station_coordinates.push(:latlng => [s.lat,s.long], :popup => "<strong>#{s.name}</strong><br>#{s.dockcount} bikes<br>#{s.start_trips.count} pickups<br>#{s.end_trips.count} dropoffs")
    end

  end
end
