# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
 before_action :configure_permitted_parameters, if: :devise_controller?

 def after_sign_in_path_for(resource)
   customers_my_page_path
 end



 protected

 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :post_code, :address, :phone_number])
 end
end