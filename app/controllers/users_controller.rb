class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @pledges = Pledge.includes(:foundation).where(user_id: current_user.id)
    @wallets = current_user.wallets
  end
end
