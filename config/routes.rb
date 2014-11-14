Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    resources :users do
      collection do
        get    :current
        get    :invited_members
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
      get    'add_member/:id',    to: 'projects#add_member',    as: 'add_member'
      delete 'remove_member/:id', to: 'projects#remove_member', as: 'remove_member'
    end
    resources :invites, only: [:index, :update, :destroy]
  end
end
