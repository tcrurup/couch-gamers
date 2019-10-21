module GamesHelper

    def show_member_count_as_link_to_developer_game_user_path_for (game)
        link_to "#{game.user_count} members own this game", developer_game_users_path(game.developer_id, game)
    end

    def show_add_game_button_for(game)
        if current_user.has_game?(game)
            button_to "Remove From Collection", "/remove_from_collection/#{game.id}" 
        else
            button_to "Add To My Games", "/add_to_current_users_games/#{game.id}" 
        end
    end

end