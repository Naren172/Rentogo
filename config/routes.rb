Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :accounts, controllers:{
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  
  root "index#user"
  get "ownerindex", to:"index#owner"
  get "renterindex", to:"index#renter"
  get "owner", to:"index#owner"


  get "renter", to: "main#index"
  get "showproduct/:id", to:"main#show", as:'showproduct'

  get "add/:productid/:renterid", to: "rental#new" ,as:'add'
  get "rentershow", to: "rental#index"
  get "renterrating/:id", to:"renters#rating", as:'renterrating'

  get "apply/:id" ,to:"applicants#new" ,as:'apply'
  get "applications/:id" ,to:"applicants#show" ,as:'show'
  get "applications" ,to:"applicants#index"
  get "view/:id" ,to:"applicants#view" ,as:'view'
  get "accept/:renterid,:productid", to:"applicants#accept", as:'accept'
  get "reject/:renterid,:productid", to:"applicants#reject", as:'reject'
  delete "delete/:id", to:"applicants#destroy", as:'delete'

  get "delivery/:paymentid/:rentalid", to: "delivery#new" ,as:'delivery'
  post "deliverys", to: "delivery#create"

  get "view-profile/:id", to:"renters#view", as:'view-profile'

  get "rentershow/:rental,:product", to:"payments#new" ,as:'payment'
  post "payment1", to:"payments#create" ,as:'payment1'
  get "paymenthistory", to:"payments#show"
  get "paymenthistories/:id", to:"payments#showproduct", as:"paymenthistories"
  get "producthistory/:id", to:"payments#producthistory", as:"producthistory"

  get "rating/:id", to:"ratings#newproduct" ,as:'rating'
  get "rrating/:id", to:"ratings#newrenter" ,as:'rrating'
  post "rratings", to:"ratings#createuser" ,as:'rratings'
  post "ratings", to:"ratings#createproduct" ,as:'ratings'
  
  resources :products


  namespace :api, default: {format: :json} do
    devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :accounts, controllers:{
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  
  root "index#user"
  get "ownerindex", to:"index#owner"
  get "renterindex", to:"index#renter"
  get "owner", to:"index#owner"

  get "renter", to: "main#index"
  get "showproduct/:id", to:"main#show", as:'showproduct'

  get "add/:productid/:renterid", to: "rental#new" ,as:'add'
  get "rentershow", to: "rental#index"
  get "renterrating/:id", to:"renters#rating", as:'renterrating'

  get "apply/:id" ,to:"applicants#new" ,as:'apply'
  get "applications/:id" ,to:"applicants#show" ,as:'show'
  get "applications" ,to:"applicants#index"
  get "view/:id" ,to:"applicants#view" ,as:'view'
  get "accept/:renterid,:productid", to:"applicants#accept", as:'accept'
  get "reject/:renterid,:productid", to:"applicants#reject", as:'reject'
  delete "delete/:id", to:"applicants#destroy", as:'delete'

  get "delivery/:paymentid/:rentalid", to: "delivery#new" ,as:'delivery'
  post "deliverys", to: "delivery#create"

  get "view-profile/:id", to:"renters#view", as:'view-profile'

  get "rentershow/:rental,:product", to:"payments#new" ,as:'payment'
  post "payment1", to:"payments#create" ,as:'payment1'
  get "paymenthistory", to:"payments#show"
  get "paymenthistories/:id", to:"payments#showproduct", as:"paymenthistories"
  get "producthistory/:id", to:"payments#producthistory", as:"producthistory"

  get "rating/:id", to:"ratings#newproduct" ,as:'rating'
  get "rrating/:id", to:"ratings#newrenter" ,as:'rrating'
  post "rratings", to:"ratings#createuser" ,as:'rratings'
  post "ratings", to:"ratings#createproduct" ,as:'ratings'

  get "getallusers", to:"main#getallusers"
  get "getallrenters", to:"main#getallrenters"
  get "productratings/:id", to:"ratings#productrating" ,as:'productratings'
  get "landing", to:"main#landing"

  resources :products
  end
end
