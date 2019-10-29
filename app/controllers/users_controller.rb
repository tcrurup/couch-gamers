class UsersController < ApplicationController
    
    before_action :set_instance_variables, 
        only: [
            :add_game, 
            :index, 
            :remove_game
        ]

    before_action :set_user_by_id, 
        only: [
            :show, 
            :update
        ]

    def add_game
        current_user.add_game(@game)
        redirect_to_current_user
    end

    def remove_game
        current_user.remove_game(@game)
        redirect_to_current_user
    end

    def facebook_users
        @users = User.facebook_users
        render :index
    end
    
    def create
        @user = User.new(user_params)
        @user.save ? (login(@user)):(render :new)
    end

    def edit
        @user = User.find(params[:id])
    end

    def index
        @game ? (@users = @game.users):(@users = User.all)
    end
    
    def new
        @user = User.new
    end

    def show
    end

    def update
        set_developer_by_id
        
        if(@developer)
            @user.add_developer(@developer)
            render :show       
        elsif @user.authenticate(params[:user][:password]) || !@user.set_pw
            
            if params[:user][:password] && !@user.set_pw
                @user.set_pw = true
            end

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

    def set_developer_by_id
        if params[:developer_id]
            @developer = Developer.find_by(id: params[:developer_id])
        else
            @developer = nil
        end
    end

    def set_game_by_id
        if @developer
            @game = @developer.games.find_by(id: params[:game_id])
        elsif params[:game_id]
            @game = Game.find_by(id: params[:game_id])
        else
            @game = nil
        end
    end

    def set_user_by_id
        @user = User.find(params[:id])
    end

    def set_instance_variables
        set_developer_by_id
        set_game_by_id
    end

    def user_params
        params.require(:user).permit(:username, :password, :first_name, :last_name, :email)
    end
end