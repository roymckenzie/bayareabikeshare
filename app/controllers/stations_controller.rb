class StationsController < ApplicationController

  def index
    @cities = Station.order(:landmark).uniq.pluck(:landmark)

    respond_to do |format|
      format.html
      format.json { render json: @cities }
    end
  end

  def by_city

    @trips = Trip.all

    if params[:city] == "All Cities";
      @stations = Station.all
      @bartStations = BartStation.all
      @caltrainStations = CaltrainStation.all
    else
      @stations = Station.where(landmark: params[:city])
      @bartStations = BartStation.where(city: params[:city])
      @caltrainStations = CaltrainStation.where(city: params[:city])
    end

    # Most popular drop off station for city
    popular_dropoff = @stations.find(@trips.where({ end_station_id: @stations.uniq.pluck(:id)}).group('end_station_id').order('count_end_station_id DESC').count('end_station_id').first[0])

    # Most popular pickup station for city
    popular_pickup = @stations.find(@trips.where({ start_station_id: @stations.uniq.pluck(:id)}).group('start_station_id').order('count_start_station_id DESC').count('start_station_id').first[0])



    # Setup GeoJSON array
    @heatmapJSON = Array.new
    @cityJSON = Array.new
    @babsGeoJSON = Array.new
    @bartGeoJSON = Array.new
    @caltrainGeoJSON = Array.new
    @payloadJSON = Array.new

    @intesity
    # Push heat map data to paylod
    @stations.each do |s|
      @heatmapJSON << [s.lat,s.lon,s.start_trips.count+s.end_trips.count]
    end

    @payloadJSON << @heatmapJSON


    # Push city stats to GeoJSON
    @cityJSON << {
      city: params[:city],
      station_count: @stations.count,
      bike_count: @stations.sum(:dockcount),
      popular_dropoff: popular_dropoff.name,
      popular_pickup: popular_pickup.name
    }

    @payloadJSON << @cityJSON


    @stations.each do |s|

      most_popular_end_station = @stations.find(s.start_trips.group('end_station_id').order('count_end_station_id DESC').count('end_station_id').first[0])
      most_popular_start_station = @stations.find(s.end_trips.group('start_station_id').order('count_start_station_id DESC').count('start_station_id').first[0])

      @babsGeoJSON << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [s.lon, s.lat]
        },
        properties: {
          name: s.name,
          bikes: s.dockcount,
          icon: 'bikeIcon',
          start_trips: s.start_trips.count,
          end_trips: s.end_trips.count,
          popular_dropoff: most_popular_end_station.name,
          popular_pickup: most_popular_start_station.name
        }
      }
    end

    @payloadJSON << @babsGeoJSON

    @bartStations.each do |b|

      @bartGeoJSON << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [b.lon, b.lat]
        },
        properties: {
          name: b.name + ' Station',
          icon: 'bartIcon'
        }
      }
    end

    @payloadJSON << @bartGeoJSON

    @caltrainStations.each do |c|

      @caltrainGeoJSON << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [c.lon, c.lat]
        },
        properties: {
          name: c.name,
          icon: 'caltrainIcon',
        }
      }
    end

    @payloadJSON << @caltrainGeoJSON

    respond_to do |format|
      format.json { render json: @payloadJSON}
    end
  end
end
