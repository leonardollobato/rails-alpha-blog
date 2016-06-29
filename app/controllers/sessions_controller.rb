class SessionsController < ApplicationController

	def new
	end
	
	def create	
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "Successfully Authenticated"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "Email and/or Password Incorrect"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash.now[:success] = "You have Logged Out"
		redirect_to root_path
	end

end