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

      most_popular_end_station = @stations.find(s.start_trips.group('end_station_id').order('count_end_station_id DESC').count('end_station_id').first[0])
      most_popular_start_station = @stations.find(s.end_trips.group('start_station_id').order('count_start_station_id DESC').count('start_station_id').first[0])

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
