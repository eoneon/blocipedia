class ChargesController < ApplicationController
  def create
    user_upgrade = UserUpgrade.new(current_user, params[:stripeToken])

    if not ChargePolicy.new(current_user, nil).create?
      flash[:alert] == "You're not allowed to do that"
      redirect_to :back
    end

    if user_upgrade.process!
      flash[:notice] = "thanks for paying"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "something went wrong"
      redirect_to new_charge_path
    end
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.username}",
      amount: Amount.default
    }

    if not ChargePolicy.new(current_user, nil).new?
      flash[:alert] == "You're not allowed to do that"
      redirect_to :back
    end
  end

  def refund
    user_downgrade = UserDowngrade.new(current_user)

    if user_downgrade.process!
      flash[:notice] = "Sorry to see the money go"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "something went wrong"
      redirect_to new_charge_path
    end
  end
end
