Rails.application.routes.draw do
    devise_for :users, controllers: {
        :registrations => "users/registrations"
      }
      # resources :users
      resources :accounts do
        resources :teams do
          post 'teams/get_name'
          post 'teams/get_teaminfo'
          resources :messages
      	end
      end
      resources :invitations 
  		  post 'invitations/get_user_mail'
  		  get 'check' => 'invitations#check_email'
   	  	root "accounts#index"
end 

     