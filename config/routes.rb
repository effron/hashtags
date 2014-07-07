Rails.application.routes.draw do

  root "tags#index"
  get "/:parent_content", to: "tags#show"
  get "/:grandparent_content/:parent_content", to: "tags#show"

  resource :tag, only: :create
end
