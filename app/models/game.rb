class Game < ApplicationRecord

    belongs_to :developer
    
    has_many :user_games
    has_many :users, through: :user_games

    validates :title, presence: true
    validates :release_year, presence: true

    def is_owned_by?(user)
        self.users.include?(user)
    end

    def add_user(user)
        self.users << user unless self.is_owned_by(user)
        user.games << self unless user.has_game?(self)
    end
    
end