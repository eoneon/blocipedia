class UserDowngrade
  def initialize(user)
    @user = user
  end

  def process!
    if refund_card && downgrade_user && unprivate_user_wikis
      return true
    end

    false
  end

  def refund_card
    charge = Stripe::Charge.retrieve(@user.stripe_charge_id)
    charge.refund

    true

  rescue Stripe::CardError => e
    @refund_failed = true
    false
  end

  def downgrade_user
    @user.role = :standard
    @user.save
  end

  def unprivate_user_wikis
    @wikis = Wiki.where(private: true, user_id: @user.id)
    @wikis.update_all(private: nil)
  end
end
