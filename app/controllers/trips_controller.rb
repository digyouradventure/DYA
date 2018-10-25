class TripsController < ApplicationController
  before_action :redirect, only: :settle
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(create_params)
    redirect_to action: 'settle'
  end

  def show
  end

  def settle
  end

  def purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      :amount => 3500,
      :card => params['payjp-token'],
      :currency => 'jpy'
    )

    redirect_to action: :complete
  end

  def complete
  end

  private
  def create_params
    if user_signed_in?
      params.require(:trip).permit(:date, :number, :budget, :ngact, :active, :loose).merge(user_id: current_user.id)
    else
      params.require(:trip).permit(:date, :number, :budget, :ngact, :active, :loose).merge(user_id: 0)
    end
  end

  def redirect
    redirect_to "/users/sign_in" unless user_signed_in?
  end

end
