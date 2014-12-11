Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  namespace :admin do
    resources :orders do
      resources :versions, only: [:index, :show]
    end
  end
end
