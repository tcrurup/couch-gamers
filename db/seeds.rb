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
    {title: "Banjo Kazooie", description: "A collectathon 3D platformer", release_year: 1998}
]

DEVELOPERS = [
    {name: "Rare"}
]

GAMES.each do |game|
    Game.create(game)
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

user1.add_game(game1)
user1.add_developer(developer1)