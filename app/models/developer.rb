class Developer < ApplicationRecord

    has_many :user_developers

    belongs_to :owner,
        foreign_key: "user_id",
        class_name:"User",
        optional: true

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

    def create_game(game)
        game.developer = self
        if game.save
            self.games << game 
        end
    end

    def employee_count
        count = self.employees.count
        count += 1 if !!self.owner
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

    def owner_name
        self.owner.full_name
    end
end