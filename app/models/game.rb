class Game < ApplicationRecord

    #create_table "games", force: :cascade do |t|
    #    t.string "title"
    #    t.text "description"
    #    t.integer "release_year"
    #    t.integer "developer_id"
    #  end

    belongs_to :developer
    
    has_many :user_games
    has_many :users, through: :user_games

    validates :title, presence: true
    validates :description, presence: true
    validates :release_year, 
        presence: true,
        inclusion: {
            in: 1960..Date.today.year,
            message: "must be between 1960 and current year" 
        }

    def developer_id
        self.developer.id
    end

    def developer_name
        self.developer.name
    end
    
    def is_owned_by?(user)
        self.users.include?(user)
    end

    def has_developer?(user)
        self.developer.has_employee?(user)    
    end

    def add_user(user)
        self.users << user unless self.is_owned_by(user)
        user.games << self unless user.has_game?(self)
    end

    def user_count
        self.users.count
    end
    
end