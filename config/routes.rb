require 'sidekiq/web'

Rails.application.routes.draw do
  resources :stylesheets
  resources :survey_types
    namespace :admin do
      resources :users
      resources :announcements
      resources :notifications
      resources :services

      root to: "users#index"
  end

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :projects do
    resources :field_notes do
      get 'show_uploaded_file'
    end
    resources :given_data do
      patch :toggle_status
    end
    resources :notes
    resources :correspondences
    resources :calc_registers
    # resources :items
    resources :tasks
    member do
      patch :toggle_status
      get :get_files
    end
    get :autocomplete_name, :on => :collection, as: :autocomplete_name
    resources :to_fields, only: [:index, :edit, :update]
  end
  get '/tasks', to: 'tasks#tasks'
  get '/new_task', to: 'tasks#new_task'
  post '/create_task', to: 'tasks#create_task'
  resources :surveyors
  resources :instruments
  resources :clients
  resources :survey_controllers
  resources :invitations, only: [:new, :create]
  resources :synchronisations, only: [:index]
  resources :time_sheets,  only: [:index,:new, :edit, :update, :create] do
    collection do
      get 'next'
      get 'previous'
      get 'add_form'
      get 'remove_form'
    end
  end
  resources :reportings, only: [:index] do
    collection do
      get 'search'
      get 'autocomplete_user_name'
      get 'search_by_user'
      get 'download_csv'
    end
  end

  resources :announcements, only: [:index]
  devise_for :users, controllers: {:registrations => "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }

  # ------------------- API ------------------- #
  namespace :api, defaults: { format: 'json' } do

    namespace :v1 do
      resources :users, :controllers => {:registrations => 'api/v1/registrations', :sessions => 'api/v1/sessions'}
      resources :projects, only: [:index, :create, :update], param: :project_number do
        collection do
          post 'create_api_params'
        end
        resources :field_notes, only: [:index, :create, :update], param: :file_id
        resources :to_fields, only: [:index, :create, :update, :destroy], param: :record_id
        resources :correspondences, only: [:create], param: :file_id
        resources :notes, only: [:create], param: :file_id
        resources :given_data, only: [:create, :update], param: :file_id
      end
      resources :surveyors, only: [:index]
      resources :instruments, only: [:index]
      resources :survey_controllers, only: [:index]
      resources :timings, only: [:index, :create, :update]
      resources :survey_types, only: [:index]
    end
  end

  authenticated  do
    root to: 'projects#index'
  end

  unauthenticated do
    root :to => redirect("/users/sign_up")
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
