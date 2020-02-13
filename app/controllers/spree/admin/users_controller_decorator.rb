module Spree
  module Admin
    module UsersControllerDecorator
      def set_theme
        session[:theme_mode] == "dark" if params[:theme_mode] && params[:theme_mode] == 'dark'
      end
    end
  end
end

::Spree::Admin::UsersController.prepend(Spree::Admin::UsersControllerDecorator)
