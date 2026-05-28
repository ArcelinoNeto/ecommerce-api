# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.assign_attributes(
  name: "Admin",
  password: "password123",
  password_confirmation: "password123",
  profile: :admin
)
admin.save!

customer = User.find_or_initialize_by(email: "customer@example.com")
customer.assign_attributes(
  name: "Customer",
  password: "password123",
  password_confirmation: "password123",
  profile: :customer
)
customer.save!

electronics = Category.find_or_create_by!(name: "Electronics") do |category|
  category.description = "Devices and accessories"
end

books = Category.find_or_create_by!(name: "Books") do |category|
  category.description = "Technical and general books"
end

Product.find_or_create_by!(name: "Wireless Keyboard") do |product|
  product.category = electronics
  product.description = "Compact Bluetooth keyboard"
  product.price = 199.90
  product.stock_quantity = 25
end

Product.find_or_create_by!(name: "Ruby on Rails Guide") do |product|
  product.category = books
  product.description = "Practical guide for Rails APIs"
  product.price = 89.90
  product.stock_quantity = 15
end
