class UserUpgrade
  def initialize(user, token)
    @user = user
    @token = token
  end

  def process!
    if charge_card && upgrade_user
      @charge.capture
      return true
    end

    false
  end

  def charge_card
    @customer = Stripe::Customer.create(
      email: @user.email,
      card: @token
    )

    @charge = Stripe::Charge.create(
      customer: @customer.id,
      amount: Amount.default,
      description: "BigMoney Membership - #{@user.email}",
      currency: 'usd',
      capture: false
    )

    true

  rescue Stripe::CardError => e
    @card_failed = true
    false
  end

  def upgrade_user
    @user.role = :premium
    @user.stripe_charge_id = @charge.id
    @user.stripe_customer_id ||= @customer.id
    @user.save
  end
end
