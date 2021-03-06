Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  devise_for :users
  devise_for :admins, :controllers => {sessions: "admin/admins/sessions", passwords: "admin/admins/passwords"},path_names: {sign_out: 'logout'}, path: 'admin/admins'
  
  namespace :admin do
    root 'index#index'
    
    resources :index do
      collection do
        get :pwd
        post :pwd_save
      end
    end
    resources :product_categories do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :products do
      member do
        get :move_up
        get :move_down
        get :set_state
      end
      
      resources :product_logos do
        member do
          get :move_up
          get :move_down
        end
      end
    end
    
    
    resources :orders do
      member do
        get :sent
        patch :sent_save
      end
    end
    
    resources :banners do
      member do
        get :move_up
        get :move_down
      end
    end
    
    resources :users
    resources :distributions
    resources :distribution_settings
    resources :coupon_templates
    resources :coupons
    resources :single_articles
    resources :settings do
      collection do
        get :new_user_handsel_coupon
        post :new_user_handsel_coupon_save
        get :recharge_card_recharge_handsel
        post :recharge_card_recharge_handsel_save
      end
    end
    resources :recharge_cards
    resources :withdraws
    resources :permissions do
      collection do
        post :refresh
      end
    end
    resources :roles do
      member do
        get :update_permissions
        post :update_permissions
        get :edit_permissions
        patch :update_permissions
      end
    end
    resources :member_admins
  end
  
  root 'index#index'
  resources :wechat do
    collection do
      get :login
      get :login_get_code_callback
      get :pay
      post :pay_notify
      post :pay_exception_notify
      get :test
    end
  end
  resources :index do
    collection do
      get :about
    end
  end
  
  resources :products
  resources :orders do
    collection do
      get :calculate_coupon
    end
  end
  
  resources :carts do
    collection do
      get :add
      get :remove
      get :reduce
      get :change
    end
  end
  
  resources :shippin_address do
    member do
      get :use
    end
  end
  
  namespace :ajax do
    resources :area do
      collection do
        get :cities
        get :streets
      end
    end
  end
  resources :agents do
    collection do
      get :index2
      get :switch
    end
  end
  resources :single_articles
  
  namespace :member do
    root 'index#index'
    resources :index
    resources :orders do
      member do
        get :set_state
        get :delete
        get :express
      end
    end
    resources :distributions do
      collection do
        get :qrcode
        get :withdraw
        post :withdraw_save
      end
    end
    resources :wallets
    resources :recharges
    resources :payments do
      collection do
        get :create
      end
    end
    resources :coupons
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
