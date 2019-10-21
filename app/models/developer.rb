class Developer < ApplicationRecord

    has_many :user_developers

    belongs_to :owner,
        foreign_key: "user_id",
        class_name:"User"

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

    def employee_count
        self.employees.count
    end

    def game_count
        self.games.count
    end

    def has_employee?(user)
        self.employees.include?(user) || self.owner == user
    end

    def has_game?(game)
        self.games.include?(game)
    end
end