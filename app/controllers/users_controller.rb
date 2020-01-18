class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    head :no_content
  end
end
