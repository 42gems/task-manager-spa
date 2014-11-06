Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    resources :users do
      get    :invited,  on: :collection
      post   :sign_in,  on: :collection
      delete :sign_out, on: :collection
    end
    resources :projects do
      resources :tasks
      get :members, on: :member

      get    'add_member/:id',    to: 'projects#add_member',    as: 'add_member'
      delete 'remove_member/:id', to: 'projects#remove_member', as: 'remove_member'
      post   'send_invite/:id',   to: 'projects#send_invite',   as: 'send_invite'
    end
  end
end
