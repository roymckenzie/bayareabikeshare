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
      most_popular_end = s.start_trips.group_by(&:end_station_id).sort_by{|key, values| values.count}.reverse.first
      most_popular_end_station = Station.find(most_popular_end[0])
      most_popular_start = s.end_trips.group_by(&:start_station_id).sort_by{|key, values| values.count}.reverse.first
      most_popular_start_station = Station.find(most_popular_start[0])
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
          end_trips: s.end_trips.count,
          popular_dropoff: most_popular_end_station.name,
          popular_pickup: most_popular_start_station.name
        }
      }
    end

    respond_to do |format|
      format.json { render json: @geojson}
    end
  end
end
