# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Feed.create(
  url: "https://cheerschopper.com/feed", 
  name: "cheerschopper.com", 
  website_url: "https://cheerschopper.com"
)

Feed.create(
  url: "https://inessential.com/feed.json", 
  name: "Inessential", 
  website_url: "https://inessential.com"
)
