class User < ApplicationRecord

    has_secure_password

    has_many :game_users
    has_many :games, through: :user_games
    
    validates :username, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
end