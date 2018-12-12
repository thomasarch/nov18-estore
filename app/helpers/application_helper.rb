module ApplicationHelper
	def money(price)
		number_to_currency(price * 0.01)
	end

	def product_pic(product)
		if product.image.url
			"autopics/#{product.image.url}"
		elsif product.autopic
			"autopics/#{product.autopic}"
		else
			default.png
		end
	end
end
