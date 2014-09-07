class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :view
  after_action :verify_authorized, except: :view

  def index
    @users = User.where("id != ?", current_user.id)
    authorize User
  end

  def view
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :picture )
  end

end