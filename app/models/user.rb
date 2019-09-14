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

    def add_developer(developer)
        self.developers << developer unless self.works_for?(developer)
        developers.employees << self unless developer.has_employee?(self)
    end

    def add_game(game)
        self.games << game unless self.has_game?(game)   
        game.users << self unless game.is_owned_by?(self) 
    end

    def has_game?(game)
        self.games.include?(game)
    end

    def is_developer?
        !self.developers.empty?
    end

    def works_for?(developer)
        self.developers.include?(developer)
    end

end