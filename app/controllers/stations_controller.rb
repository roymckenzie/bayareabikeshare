class StationsController < ApplicationController

  def index

    @cities = Station.order(:landmark).uniq.pluck(:landmark)

    respond_to do |format|
      format.html
      format.json { render json: @cities }
    end
  end

  def by_city

    if params[:city] == "All Cities";
      @stations = Station.all
    else
      @stations = Station.where(landmark: params[:city])
    end
    @geojson = Array.new

    @geojson << {
      city: params[:city],
      station_count: @stations.count
    }

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
