require 'faker'
require 'date'
require 'csv'

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby .fetchtest/generate_product_seeds.rb
# if satisfied with this file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open('.fetchtest/product_seeds.csv', "w", :write_headers=> true,
  :headers => ["category", "name", "quantity", "price", "image", "user_id"]) do |csv|

    50.times do |i|
      category = %w(Plants Paraphernalia Fashion Beauty Lifestyle).sample
      if category == "Plants"
        name = Faker::Ancient.primordial + " " + Faker::Zelda.item
        quantity = rand(25)
        price = 6.66
        image = "https://placekitten.com/200/200"
        user_id = 1
      end
      if category == "Paraphernalia"
        name = Faker::Robin.quote + " " + Faker::GameOfThrones.house
        quantity = rand(25)
        price = 6.66
        image = "https://placekitten.com/200/200"
        user_id = 1
      end
      if category == "Fashion"
        name = Faker::Nation.capital_city + " " + Faker::TwinPeaks.location
        quantity = rand(25)
        price = 6.66
        image = "https://placekitten.com/200/200"
        user_id = 1
      end
      if category == "Beauty"
        name = Faker::Ancient.primordial + " " + Faker::Dessert.flavor
        quantity = rand(25)
        price = 6.66
        image = "https://placekitten.com/200/200"
        user_id = 1
      end
      if category == "Lifestyle"
        name = Faker::Nation.national_sport + " " +  Faker::Dog.meme_phrase
        quantity = rand(25)
        price = 6.66
        image = "https://placekitten.com/200/200"
        user_id = 1
      end

      csv << [category, name, quantity, price, image, user_id]
    end
  end
