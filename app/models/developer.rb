class Developer < ApplicationRecord

    has_many :user_developers
    
    has_many :employees, 
        through: :user_developers, 
        foreign_key: "user_id", 
        class_name:"User",
        source: :user

    has_many :games

    validates :name, presence: true

    def add_employee(user)
        self.employees << user unless self.has_employee?(user)
        user.developers << self unless user.works_for?(self)
    end

    def add_game(game)
        unless self.has_game?(game)
            self.games << game 
            game.developer = self
        end
    end

    def has_employee?(user)
        self.employees.include?(user)
    end

    def has_game?(game)
        self.games.include?(game)
    end
end