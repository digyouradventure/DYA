class UsersController < ApplicationController
  before_action :move_to_index, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @trips = @user.trips
  end

  def edit
  end

  def update
  end

  private
  def move_to_index
    redirect_to :root unless params[:id].to_i == current_user.id
  end
end
