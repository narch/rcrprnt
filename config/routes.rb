Spree::Core::Engine.add_routes do
  post "/get_product_options/:product_id",
       to: "products#get_product_options",
       as: "get_product_options",
       constraints: { :format => /(js)/ }

  namespace :admin do
    resources :stores
  end
end
