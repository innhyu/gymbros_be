class UsersController < ApplicationController
	#standard api CRUD controller
	before_action :set_user, only: [:show, :update, :destroy]
	authorize_resource

	def index
		@users = User.all
		render json: @users
	end

	def show
		render json: @user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user, status: :created, location: @user
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def update
		if @user.update(user_params)
			render json: @user
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@user.delete
	end

	private
	def set_user
		@user.User.find(params[:id])
	end

	def user_params
		params.permit(:facebook_id, :email, :password, :role, :first_name, :last_name, :gender, :age)
	end
end