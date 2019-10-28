class User < ApplicationRecord

    #create_table "users", force: :cascade do |t|
    #    t.string "username"
    #    t.string "first_name"
    #    t.string "last_name"
    #    t.string "email"
    #    t.string "password_digest"
    #    t.integer "developer_id"
    #    t.string "uid"
    #    t.string "image"
    #    t.boolean "set_pw", default: true
    #end
    
    has_secure_password

    #ASSOCIATIONS
    has_one :owned_developer,
        class_name: "Developer"        
    
    has_many :user_developers
    has_many :developers, through: :user_developers

    has_many :user_games
    has_many :games, through: :user_games
    
    #CALLBACKS

    #SCOPES
    scope :facebook_users, -> { where("uid > 0") }


    #VALIDATIONS
    validates :username, 
        presence: true,
        uniqueness: {
            message: "is already in use"    
        }

    
    validates :email, 
        presence: true,
        uniqueness: {
            message: " is already in user by another user"
        }

    validates :first_name, presence: true
    validates :last_name, presence: true

    #FUNCTIONS

    def add_developer(developer)
        self.developers << developer unless self.works_for?(developer)
        developers.employees << self unless developer.has_employee?(self)
    end

    def add_game(game)
        self.games << game unless self.has_game?(game)   
        game.users << self unless game.is_owned_by?(self) 
    end

    def new_developer(developer_params={})
        Developer.new(developer_params).tap do |x|
            x.owner = self
        end
    end

    def developer_name
        self.owned_developer.name
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

    def owned_developer_name
        self.owned_developer.name
    end

    def owns_developer?
        !!self.owned_developer
    end

    def works_for?(developer)
        self.developers.include?(developer) || self.owned_developer === developer
    end

end