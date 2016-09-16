class ChargesController < ApplicationController

  after_action :upgrade_account, only: :create
  after_action :downgrade_account, only: :refund

  def create
    # create a Stripe Customer object, for associating
    @customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      customer: @customer.id,
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    # redirect_to :back
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.username}",
      amount: Amount.default
    }
  end

  def refund 
    user = current_user
    charge = Stripe::Charge.retrieve(
      charge: user.stripe_charge_id
    )
    charge.refund

    flash[:notice] = "Sorry to see the money go, #{current_user.email}!"
    # redirect_to :back
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_refund_path
  end
end
