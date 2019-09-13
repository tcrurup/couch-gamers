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

GAMES.each do |game|
    Game.create(game)
end

USERS.each do |user|
    User.create(user)
end

User.all.first.add_to_collection(Game.all.first)