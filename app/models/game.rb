class Game < ApplicationRecord

    has_many :user_games
    has_many :users, through: :user_games

    def is_owned_by?(user)
        self.users.include?(user)
    end

    def add_user(user)
        self.users << user unless self.users.include?(user)
    end
    
end