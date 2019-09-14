# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USERS = [
    {username: "tcrurup", first_name: "tony", last_name: "rurup", email: "tcrurup@gmail.com", password: "tactics"}
]

GAMES = [
    {title: "Banjo Kazooie", developer_id: 1, description: "Banjo-Kazooie is a single-player platform game where the player controls the protagonists Banjo and Kazooie from a third-person perspective. The game features nine worlds where the player must gather musical notes and jigsaw pieces, called Jiggies, to progress.", release_year: 1998},
    {title: "Final Fantasy 7", developer_id: 2, description: "Final Fantasy VII follows the story of mercenary Cloud Strife, who is hired by the eco-terrorist group AVALANCHE—led by Barret Wallace—to help fight the mega-corporation Shinra Electric Power Company, who attempts to drain the planet's lifeblood as an energy source to further their profits.", release_year: 1997}
]

DEVELOPERS = [
    {name: "Rare"},
    {name: "Square"}
]

GAMES.each do |game|
    Game.create(game)
    binding.pry
end

USERS.each do |user|
    User.create(user)
end

DEVELOPERS.each do |developer|
    Developer.create(developer)
end

user1 = User.first
game1 = Game.first
developer1 = Developer.first

binding.pry
user1.add_game(game1)
user1.add_developer(developer1)