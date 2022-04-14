# frozen_string_literal: true

# Controller for User routes
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  # |---|| GET methods ||---|
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end
  # |---|| GET methods ||---|

  # POST method for the users. | /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT method for the user edit. | /user/:id
  def update
    if @user.update(user_params)
      flash[:notice] = 'Your account information was successfully updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE method for the user. | /user/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:alert] = 'User and all articles created by user have been deleted'
    redirect_to articles_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return unless current_user != @user && !current_user.admin?

    flash[:alert] = 'You can only edit or delete your own account'
    redirect_to @user
  end
end
