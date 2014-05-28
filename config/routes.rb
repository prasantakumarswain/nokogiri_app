Rails.application.routes.draw do
  resources :products
  resources :categories do
    #collection do
    #  post "search"
    #end
    resources :products
  end


  root 'categories#index'

end
