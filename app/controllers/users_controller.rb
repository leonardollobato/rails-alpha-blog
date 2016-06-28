class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	
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
			flash[:success] = "Welcome #{@user.username}"
			redirect_to articles_path
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

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:email,:password)
	end
end