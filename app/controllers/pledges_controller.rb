class PledgesController < ApplicationController
  before_action :authenticate_user!

  def new
    @foundation = Foundation.find(params[:id])
    @pledge = Pledge.new
  end

  def create
    @foundation = Foundation.find(params[:id])
    @pledge = Pledge.new(
                amount: params[:amount],
                foundation_id: params[:id],
                user_id: current_user.id,
                currency: @foundation.local_currency
              )

    if @pledge.save
      if @foundation.deploy
        flash[:success] = "Congratulations! Your pledge was created and the foundation was deployed to the Ethereum blockchain. "
      end

      flash[:success] = "Your pledge has been created!"
      @foundation.activate
      redirect_to pledge_path(@pledge)
    end

  end

  def show
    @decorated_pledge = PledgeDecorator.new(Pledge.find(params[:id]))
  end

  def cancel
  end

  def pledge_params
    params.require(:pledge).permit(:amount)
  end
end
