class ChargesPolicy
  attr_reader :user, :charge

  def initialize(user, charge)
    @user = user
    @charge = charge
  end

  def new?
    @user.role == 'standard'
  end
end
