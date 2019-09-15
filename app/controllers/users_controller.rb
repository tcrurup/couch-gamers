class UsersController < ApplicationController

    def add_to_current_users_games
        @game = Game.find_by(id: params[:game_id])
        current_user.add_game(@game)
        redirect_to user_path(current_user)
    end
    
    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            login(@user)
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def index
        if params[:developer_id] && params[:game_id]
            @developer = Developer.find_by(id: params[:developer_id])
            @game = @developer.games.find_by(id: params[:game_id])
            @users = @game.users
        else 
            @users = User.all
        end
    end
    
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.authenticate(params[:user][:password])
            if @user.update(user_params)
                redirect_to user_path(@user)
            else
                render :edit
            end
        else
            render :edit
        end
    end

    private

    def login(user)
        session[:user_id] = user.id
        redirect_to user_path(@user)
    end

    def user_params
        params.require(:user).permit(:username, :password, :first_name, :last_name, :email)
    end
end