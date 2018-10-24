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

user1 = User.new(name: 'Addison', username: 'fetch dev addy', email: 'teamfetch@fetch.com', uid: 36283115, provider: 'github', merchant: false, profile_picture: "https://avatars.githubusercontent.com/addisoncole" )
user2 = User.new(name: 'Hayden', username: 'fetch dev hayden', email: 'teamfetch@fetch.com', uid: 35811280, provider: 'github', merchant: false, profile_picture: "https://avatars.githubusercontent.com/haydenwilliams")
user3 = User.new(name: 'Karis', username: 'fetch dev karis', email: 'teamfetch@fetch.com', uid: 17921445, provider: 'github', merchant: false, profile_picture: "https://avatars.githubusercontent.com/kimj42")
user4 = User.new(name: 'Naheed', username: 'fetch dev naheed', email: 'teamfetch@fetch.com', uid: 35782635, provider: 'github', merchant: false, profile_picture: "https://avatars.githubusercontent.com/arangn")

user5 = User.new(name: 'Nicki', username: 'minajmirage', email: 'nicki@minaj.com', uid: 45678242, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "LUX", store_banner_img:"https://picsum.photos/1000?image=1021" , store_location: "Hyperspace, USA", store_description: "Shout out to my h8rs, sorry you couldn't please me")
user6 = User.new(name: 'Rhi', username: 'keepnririreal', email: 'rhi@anna.com', uid: 44444112, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "fenty-two", store_banner_img: "https://picsum.photos/1000?image=1014" , store_location: "Hyperspace, USA", store_description: "Never lower your standards, for anyone")
user7 = User.new(name: 'Riff', username: 'riff raff', email: 'riff@raff.com', uid: 45678226, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "Ruff Stuf", store_banner_img: "https://picsum.photos/1000?image=972", store_location: "Hyperspace, USA", store_description: "Life is TRASH")
user8 = User.new(name: 'Miley', username: 'justmiley', email: 'miley@cyrus.com', uid: 45486782, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "Wrecking Mall", store_banner_img: "https://picsum.photos/1000?image=959", store_location: "Hyperspace, USA", store_description:"Pink isn't just a color, it's an attitude!")
user9 = User.new(name: 'Serena', username: 'racketgrrl', email: 'serena@williams.com', uid: 44567082, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "Racket", store_banner_img: "https://picsum.photos/1000?image=840", store_location: "Hyperspace, USA", store_description: "You have to believe in yourself when no one else does.")
user10 = User.new(name: 'Selena', username: 'gogogomez', email: 'selena@gomez.com', uid: 40056782, provider: 'github', merchant: true, profile_picture: "https://loremflickr.com/320/240/dog", store_name: "Bad Liar", store_banner_img: "https://picsum.photos/1000?image=660" , store_location: "Hyperspace, USA", store_description: "You have every right to a beautiful life")

users_list = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]

user_failures = []

users_list.each do |user|
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end


puts "Added #{User.count} user records"
puts "#{user_failures.length} product failed to save"

PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'products.csv')
puts "Loading raw driver data from #{PRODUCT_FILE}"

merchants = [5, 6, 7, 8, 9, 10]
product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.category = row['category']
  product.name = row['name']
  product.quantity = row['quantity']
  product.price = row['price']
  product.image = row['image']
  product.user_id = merchants.sample
  successful = product.save!
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
