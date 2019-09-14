class Developer < ApplicationRecord

    has_many :user_developers
    has_many :users, through: :user_developers

    validates :name, presence: true
    
end