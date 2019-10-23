class GamesController < ApplicationController
    
    #User must be logged in before an actions in the game contoller are allowed to take place
    before_action :require_login

    def create
        #Only developers and people employed by developers can create games
        set_developer_by_id

        if @developer.has_employee?(current_user)         
            @game = @developer.create_game(Game.new(game_params))
            if @game.save                
                redirect_to developer_game_path(@game.developer, @game)
            else
                render :new
            end
        else
            redirect_to user_path(current_user)
        end
    end

    def destroy
        set_game_by_id
        set_developer_by_id
        message = nil;
        
        #Checks to verify the current logged in user is a associated with the developer for that game and also that the game
        #belongs to that developer
        if !@developer.has_employee?(current_user)
            message = "You are not a developer for #{@developer.name}"
        elsif !@developer.has_game?(@game)
            message = "#{@developer.name} does no own #{@game.title}"            
        end
        
        unless message
            message = "#{@game.title} has been removed" 
            @game.destroy
        end         

        flash_and_redirect_to_show_page(@developer, message)        
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