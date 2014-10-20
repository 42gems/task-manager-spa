Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    resources :users do
      post :sign_in,    on: :collection
      delete :sign_out, on: :collection
    end
    resources :projects
  end
end
