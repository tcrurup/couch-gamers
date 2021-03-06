# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USERS = [
    {username: "tcrurup", first_name: "tony", last_name: "rurup", email: "tcrurup@gmail.com", password: "tactics"},
    {username: "capplen", first_name: "cody", last_name: "applen", email: "capplen@gmail.com", password: "cody"},
    {username: "nlegrand", first_name: "nathan", last_name: "legrand", email: "nlegrand@gmail.com", password: "nathan"},
    {username: "nkhan", first_name: "nazif", last_name: "khan", email: "nkhan@gmail.com", password: 'nazif'}
]

RARE_GAMES = [
    {
        title: "Banjo Kazooie",  
        description: "Banjo-Kazooie is a single-player platform game where the player controls the protagonists Banjo and Kazooie from a third-person perspective. The game features nine worlds where the player must gather musical notes and jigsaw pieces, called Jiggies, to progress.", 
        release_year: 1998
    },
    {
        title: "Conker's Bad Fur Day", 
        description: "Conker's Bad Fur Day is a platformer video game where the player controls Conker the Squirrel through a series of three-dimensional levels. The game features an overworld where players can transition from one level to another, although many are initially blocked off until Conker earns a certain amount of cash.", 
        release_year: 2001
    },
    {
        title: "Donkey Kong 64", 
        description: "The first in the Donkey Kong series to feature 3D gameplay. As the gorilla Donkey Kong, the player explores the themed levels of an island to collect items and rescue his kidnapped friends from King K. Rool. The player completes minigames and puzzles as five playable Kong characters—each with its own special abilities—to receive bananas and other collectibles.", 
        release_year: 1999
    }
]
SQUARE_GAMES = [  
    {
        title: "Final Fantasy 7", 
        description: "Final Fantasy VII follows the story of mercenary Cloud Strife, who is hired by the eco-terrorist group AVALANCHE—led by Barret Wallace—to help fight the mega-corporation Shinra Electric Power Company, who attempts to drain the planet's lifeblood as an energy source to further their profits.", 
        release_year: 1997
    },
    {
        title: "Chrono Trigger", 
        description: "The game's story follows a group of adventurers who travel through time to prevent a global catastrophe.", 
        release_year: 1995
    },
    {
        title: "Super Mario RPG", 
        description: "The first Mario role-playing game with an action-command battle system. In this game, Mario, with the help of Mallow, Geno, Bowser, and Princess Toadstool, needs to stop a new enemy, the Smithy Gang, while collecting seven Star Pieces so that peace may return and wishes may be granted once more. ", 
        release_year: 1996
    }
]

USERS.each do |user|
    User.create(user)
end

user1 = User.all[0]
user2 = User.all[1] 


rare = user1.new_developer({name: "Rare"});
square = user2.new_developer({name: "Square"});

rare.save
square.save

RARE_GAMES.each do |game|
    rare.create_game(game)
end

SQUARE_GAMES.each do |game|
    square.create_game(game)
end


