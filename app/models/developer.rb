class Developer < ApplicationRecord

    #create_table "developers", force: :cascade do |t|
    #    t.string "name"
    #    t.integer "user_id"
    #  end

    
    #ASSOCIATIONS
    belongs_to :owner,
        foreign_key: "user_id",
        class_name:"User",
        optional: true

    
    has_many :games
    has_many :user_developers

    has_many :employees, 
        through: :user_developers, 
        foreign_key: "user_id", 
        class_name:"User",
        source: :user

    #VALIDATIONS
    validates :name, 
        presence:{
            message: "can't be blank"
        }
    validates :user_id,
        uniqueness:{
            message: "can only be the owner of one developer studio"
        }
        
    #FUNCTIONS  
    def add_employee(user)
        self.employees << user unless self.has_employee?(user)
        user.developers << self unless user.works_for?(self)
    end

    def create_game(game_params)
        new_game(game_params).save
    end

    def new_game(game_params={})
        Game.new(game_params).tap do |x|
            x.developer = self
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

    def owns_game?(game)
        self.games.include?(game)
    end

    def owner_name
        self.owner.full_name
    end
end