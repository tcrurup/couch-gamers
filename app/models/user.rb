class User < ApplicationRecord

    has_secure_password

    has_one :ownedDeveloper,
        class_name: "Developer"        
    
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

    def remove_game(game)
        self.games.delete(game)
        game.users.delete(self)
    end

    def full_name
        "#{self.first_name.capitalize} #{self.last_name.capitalize}"
    end

    def full_name=(full_name)
        split_name = full_name.split(" ")
        self.first_name = split_name.first
        self.last_name = split_name.last
        self.save
    end

    def has_game?(game)
        self.games.include?(game)
    end

    def is_developer?
        !self.developers.empty?
    end

    def works_for?(developer)
        self.developers.include?(developer) || self.ownedDeveloper === developer
    end

end