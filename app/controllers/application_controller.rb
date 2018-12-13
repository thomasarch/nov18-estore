class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :categories, :brands

	before_action :configure_permitted_parameters, if: :devise_controller?

	helper_method :current_order

	def current_order
		if !session[:order_id].nil?
			Order.find(session[:order_id])
		else
			Order.new
		end
	end

	def categories
		@categories = Category.order(:name)
	end

	def brands
		@brands = Product.pluck(:brand).sort.uniq
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :role])

		devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :role])
	end
end
