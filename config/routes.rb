Rails.application.routes.draw do
  get '/refresh_data' => 'rtppm_snapshots#update'

  root to: 'rtppm_snapshots#show'
end
