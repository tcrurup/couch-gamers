class User < ApplicationRecord

    has_secure_password

    
    has_many :user_developers
    has_many :developers, through: :user_developers

    has_many :user_games
    has_many :games, through: :user_games
    
    validates :username, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true

    def add_to_collection(game)
        self.games << game unless self.has_game?(game)   
        game.users << self unless game.is_owned_by?(self) 
    end

    def has_game?(game)
        self.games.include?(game)
    end
end