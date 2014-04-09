Bayareabikeshare::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'stations#index'

  get "stations/index"
  get "stations/by_city"

end
