class Game < ApplicationRecord

    scope :all_developed_by, -> {}

    #The optional is temporary, the developer should be the only one able to create games so should belong by default
    belongs_to :developer, optional: true
    
    has_many :user_games
    has_many :users, through: :user_games

    validates :title, presence: true
    validates :release_year, presence: true

    def developer_id
        self.developer.id
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