module ApplicationHelper
	def money(price)
		number_to_currency(price * 0.01)
	end
end
