Rails.application.routes.draw do
 get "renter", to: "main#index"
 get "owner", to:"index#owner"
#  get "sign-up", to: "registration#new"
 get "sign-in", to: "session#new"
 post "sign-in", to: "session#create"

  get "add/:id", to: "rental#new" ,as:'add'
  get "rentershow", to: "rental#index"
  get "apply/:id" ,to:"applicants#new" ,as:'apply'
  get "show/:id" ,to:"applicants#show" ,as:'show'
  get "applications" ,to:"applicants#index"
  get "view/:id" ,to:"applicants#view" ,as:'view'
  get "view-profile/:id", to:"renters#view", as:'view-profile'
  get "accept/:id", to:"applicants#accept", as:'accept'
  get "reject/:id", to:"applicants#reject", as:'reject'
  delete "delete/:id", to:"applicants#destroy", as:'delete'
  get "showproduct/:id", to:"main#show", as:'showproduct'
  get "payment/:rental,:product", to:"payments#new" ,as:'payment'
  post "payment1", to:"payments#create" ,as:'payment1'
  get "rating/:id", to:"ratings#newproduct" ,as:'rating'
  get "rrating/:id", to:"ratings#newrenter" ,as:'rrating'
  post "rratings/:id", to:"ratings#createrenter" ,as:'rratings'
  post "ratings", to:"ratings#createproduct" ,as:'ratings'
  get "ownerindex", to:"index#owner"
  get "renterindex", to:"index#renter"
  get "paymenthistory", to:"payments#show"
  get "paymenthistories/:id", to:"payments#showproduct", as:"paymenthistories"
  get "producthistory/:id", to:"payments#producthistory", as:"producthistory"

  # post "checkout/create", to:"checkout#create"

  # get "reviews/:id", to:
#  get "product", to: "products#index"
#  get "product/:id", to: "products#show"
#  resources :checkout, only: [:create]
 resources :products



end
