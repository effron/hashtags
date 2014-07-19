Rails.application.routes.draw do

  root "mappings#index"
  get "/:parent_content", to: "mappings#show"
  get "/:grandparent_content/:parent_content", to: "mappings#show"

  resource :mapping, only: :create
end
