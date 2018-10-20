# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

user = User.new(name: 'fetch devs', username: 'fetch.', email: 'teamfetch@fetch.com')
successful = user.save

user_failures = []
if !successful
  user_failures << user
  puts "Failed to save user: #{user.inspect}"
else
  puts "Created user: #{user.inspect}"
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} product failed to save"

PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'products.csv')
puts "Loading raw driver data from #{PRODUCT_FILE}"

@user = User.first
product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.category = row['category']
  product.name = row['name']
  product.quantity = row['quantity']
  product.price = row['price']
  product.user_id = @user.id
  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
