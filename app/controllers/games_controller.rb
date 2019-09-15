class GamesController < ApplicationController
    
    before_action :require_login

    def create
       
        set_developer_by_id
        if current_user_works_for_developer? == true
            
            @game = Game.new(game_params)

            if @game.valid?
                @game.save
                redirect_to developer_game_path(@game.developer, @game)
            else
                render :new
            end
        else
            redirect_to user_path(current_user)
        end
    end

    def destroy
        @game = Game.find_by(id: params[:id])
        set_developer_by_id

        errors = ["There was a problem with the following:"]
        errors << "#{@developer.name} does no own #{@game.title}" unless @developer.has_game?(@game)
        errors << "You are not a developer for #{@developer.name}" unless @developer.has_employee?(current_user)
        
        if errors.length > 1 
            flash_and_redirect_to_show_page(@game, errors.join(" "))       
        else
            @game.destroy
            redirect_to games_path
        end
    end

    def edit
        set_game_by_id
    end
    
    def new
        set_developer_by_id
        if @developer.nil?
            flash_and_redirect_to_show_page(current_user, "No developer with that id")
        elsif current_user.works_for?(@developer)
            @game = Game.new(developer_id: @developer.id)
        else
            flash_and_redirect_to_show_page(current_user, "You don't work for #{@developer.name}")
        end
    end

    def index
        if params[:developer_id]
            @games = Developer.find(params[:developer_id]).games
        else
            @games = Game.all
        end
    end

    def show
        if params[:developer_id]
            set_developer_by_id
            @game = @developer.games.find_by(id: params[:id])
            if @game.nil? 
                message = "#{@developer.name} does not have a game with that id"
                flash_and_redirect_to_show_page(@developer, message)
            end                
        else
            set_game_by_id
        end
    end

    def update
        set_game_by_id
        @game.update(game_params)

        if @game.valid?
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    private

    def current_user_works_for_developer?        
        if @developer.nil?
            flash[:message] = "No developer with id#{params[:developer_id]}"
        elsif !current_user.works_for?(@developer)
            flash[:message] = "You dont work for #{@developer.name}"
        else
            true
        end
    end

    def game_params
        params.require(:game).permit(:title, :description, :release_year, :developer_id)
    end

    def set_game_by_id
        @game = Game.find_by(id: params[:id])
    end

    def set_developer_by_id
        @developer = Developer.find_by(id: params[:developer_id])
    end
end