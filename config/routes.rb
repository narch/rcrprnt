Spree::Core::Engine.add_routes do
  post "products/:product_id/get_product_options",
       to: "products#get_product_options",
       as: "get_product_options",
       constraints: { :format => /(js)/ }

  namespace :admin do
    resources :stores
  end
end
