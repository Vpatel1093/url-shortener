Rails.application.routes.draw do
  root 'url#new'

  get '/:shortened_url_token', to: 'url#show'
  post '/shortened_urls' => 'url#create', format: :json
end
