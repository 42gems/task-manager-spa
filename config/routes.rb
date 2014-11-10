Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    resources :users do
      collection do
        get    :current
        get    :invited
        post   :sign_in
        delete :sign_out
      end
    end
    resources :projects do
      resources :tasks
      member do
        get :members
        get :users_for_invite
      end
      get    'send_invite/:id',   to: 'projects#send_invite',   as: 'send_invite'
      delete 'remove_member/:id', to: 'projects#remove_member', as: 'remove_member'
    end
    resources :invites, only: [:index, :update, :destroy]
  end
end
