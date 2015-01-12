Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    resources :users do
      member do
        get :projects
        get :invited_members
      end
      collection do
        get    :current
        post   :sign_in
        delete :sign_out
      end
    end
    resources :projects do
      resources :tasks do
        resources :timetracks
      end
      member do
        get :members
        get :time_stats
        get :user_rights
        get :users_for_invite
        get :timeline_matrix
      end
      patch  'add_member/:id',    to: 'projects#add_member',    as: 'add_member'
      delete 'remove_member/:id', to: 'projects#remove_member', as: 'remove_member'
    end
    resources :invites, only: [:index, :update, :destroy] do
      collection do
        get :pending_invites
      end
    end
  end
end
