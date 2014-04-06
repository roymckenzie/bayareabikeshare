class StationsController < ApplicationController
  def index

    @stations = Station.all

    #Get an array of coordinates for map
    @station_coordinates = Array.new
    @stations.each do |s|
      @station_coordinates.push(:latlng => [s.lat,s.long], :popup => "#{s.name}")
    end

  end
end
