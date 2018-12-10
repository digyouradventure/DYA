class TripsController < ApplicationController
  before_action :redirect, only: :settle
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(create_params)
    respond_to do |format|
      if @trip.save
        # UserMailer.send_email(current_user).deliver_later
        format.html{ redirect_to(current_user, notice: '旅行の登録が完了しました。') }
        format.json{ render json: current_user, status: :created, location: current_user }
      else
        format.html{ render action: 'new' }
        format.json{ render json: current_user.errors, status: :unprocessable_entity }
      end
    end
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
      binding.pry
      params.require(:trip).permit(:date, :number, :budget, :ngact, :active, :loose).merge(user_id: current_user.id)
    else
      params.require(:trip).permit(:date, :number, :budget, :ngact, :active, :loose).merge(user_id: 0)
    end
  end

  def redirect
    redirect_to "/users/sign_in" unless user_signed_in?
  end
end
