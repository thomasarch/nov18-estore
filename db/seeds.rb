# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

def destroy
	Category.destroy_all
	Product.destroy_all
	FileUtils.rm_rf(Dir['app/assets/images/autopics/*'])
end


def seed_appliances(appliance_count, brand_count)
	brands = []
	until brands.count == brand_count
		brand = Faker::Appliance.brand
		brands.include?(brand) ? '' : brands.push(brand)
	end

	appliances = []
	until appliances.count == appliance_count
		item = [Faker::Appliance.equipment, brands.sample]
		appliances.include?(item) ? '' : appliances.push(item)
	end

	appliances.each do |item|
		Product.create!(
			name: item[0],
			price: set_price,
			quantity: 144,
			description: "#{Faker::Company.catch_phrase} to #{Faker::Company.bs}",
			category_id: Category.first.id,
			autopic: nokopiri(item[0]),
			brand: item[1]
		)
	end
end


def seed_cars(car_count)
	cars = []
	until cars.count == car_count
		car = Faker::Vehicle.make_and_model
		cars.include?(car) ? '' : cars.push(car)
	end

	cars.each do |car|
		item = car.split
		Product.create!(
			name: item[1],
			price: set_price,
			quantity: 144,
			description: "#{Faker::Company.catch_phrase} to #{Faker::Company.bs}",
			category_id: Category.last.id,
			autopic: nokopiri(car),
			brand: item[0]
		)
	end
end


def search_string(product)
	string = ''
	product.split(' ').each do |word|
		string.concat("#{word}+")
	end
	string
end


def nokopiri(product)
	img = Nokogiri::HTML(open(
		"https://www.google.com/search?tbm=isch&q=#{search_string(product)}"))
		.css('img')[0].attr('src')
	product = product.delete(' ')
	File.open("app/assets/images/autopics/#{product}.png", 'wb'){|f| f.write(open(img).read)}
	product
end


def set_price
	rand(1..100) * 1000 - 1
end

destroy

categories = Category.create([
	{name: "Appliances"},
    {name: "Cars"}
])

seed_appliances(10, 3)
seed_cars(10)
