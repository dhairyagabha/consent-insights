class ApplicationController < ActionController::Base
  impersonates :user
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_property, if: :current_user

  protected


    def set_property
      if Property.all.any?
        if !session[:property_id]
          session[:property_id] = Property.first.id
        elsif session[:property_id]
          @property = Property.find(session[:property_id])
        end
      else
        session.delete(:property_id)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end
end
