Rails.application.routes.draw do
  get "/", to: "welcome#index"
  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:id", to: "shelters#destroy"

  get "/shelters/:id/pets", to: "shelter_pets#index"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/shelters/:id/pets/new", to: "pets#new"
  post "/shelters/:id/pets", to: "pets#create"
  get "/pets/:id/edit", to: "pets#edit"
  post "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/reviews/new", to: "shelter_reviews#new"
  post "/shelters/:shelter_id/reviews", to: "shelter_reviews#create"
end
