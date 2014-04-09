class CaltrainStation < ActiveRecord::Base

reverse_geocoded_by :lat, :lon do |obj,results|
  if geo = results.first
    obj.city    = geo.city
  end
end
after_validation :reverse_geocode

end
