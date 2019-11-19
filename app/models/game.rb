class Game < ApplicationRecord

    #SCHEMA
    #create_table "games", force: :cascade do |t|
    #    t.string "title"
    #    t.text "description"
    #    t.integer "release_year"
    #    t.integer "developer_id"
    #  end

    #ASSOCIATIONS
    belongs_to :developer

    has_many :user_games
    has_many :users, through: :user_games

    #SCOPES
    scope :created_by, ->(developer_id) { where("developer_id = ?", developer_id) } 

    #VALIDATIONS
    validates :title, presence: true
    validates :description, presence: true
    validates :release_year, 
        presence: true,
        inclusion: {
            in: 1960..Date.today.year,
            message: "must be between 1960 and current year" 
        }

    #FUNCTIONS
    def developer_id
        self.developer.id
    end

    def developer_name
        self.developer.name
    end

    def favorited?(user)
        UserGame.find_or_create_by(game_id: self.id, user_id: user.id).favorited
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

    def toggle_favorite(user)
        userGame = UserGame.find_or_create_by(game_id: self.id, user_id: user.id)
        binding.pry
        if userGame.favorited
            binding.pry
            userGame.favorited = false
        else
            binding.pry
            userGame.favorited = true
        end
        binding.pry
        userGame.save
    end

    def user_count
        self.users.count
    end

    def user_has_permission_to_CRUD?(user)       
        if self.developer.has_employee?(user)
            true
        else
            errors.add :base, "You do not work for #{self.developer_name}"
            false
        end
    end  
    
end