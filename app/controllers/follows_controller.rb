class FollowsController < ApplicationController
	def create 
		@user = User.find(params[:follows][:user])
		current_user.follow(@user) 
	end

end
