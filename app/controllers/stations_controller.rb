class StationsController < ApplicationController

  def index

    @cities = Station.order(:landmark).uniq.pluck(:landmark)

  end

  def by_city

    @stations = Station.where(landmark: params[:city])
    @geojson = Array.new

    @stations.each do |s|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [s.lon, s.lat]
        },
        properties: {
          name: s.name,
          bikes: s.dockcount,
          start_trips: s.start_trips.count,
          end_trips: s.end_trips.count
        }
      }
    end

    respond_to do |format|
      format.json { render json: @geojson}
    end
  end
end
