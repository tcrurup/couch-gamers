class UserGame < ApplicationRecord

    belongs_to :user
    belongs_to :game

    before_save :set_values

    def set_values
        self.favorited = false;
    end


end
