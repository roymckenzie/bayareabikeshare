class CaltrainStation < ActiveRecord::Base

reverse_geocoded_by :lat, :lon do |obj,results|
  if geo = results.first
    obj.city    = geo.city
  end
  sleep(2) # Google Geocoder API may deny requests to geocode if they come in to fast.
end

after_validation :reverse_geocode

end
