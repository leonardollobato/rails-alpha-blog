class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		@users = User.paginate(page: params[:page], per_page:3)	
	end

	def new
		@user = User.new
	end
	
	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page:3)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "User #{@user.username} Update!"
			redirect_to articles_path
		else
			render 'edit'
		end
		
	end

	def destroy
		if @user.destroy
			flash[:success] = "User Removed!"
			redirect_to users_path
		else
			render 'index'
		end
	end

	private

	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:danger] = "You cannot edit someone else record"
			redirect_to root_path
		end
	end

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:email,:password)
	end
end