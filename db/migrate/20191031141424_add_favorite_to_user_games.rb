class AddFavoriteToUserGames < ActiveRecord::Migration[6.0]
  def change
      add_column :user_games, :favorited, :boolean
  end
end
