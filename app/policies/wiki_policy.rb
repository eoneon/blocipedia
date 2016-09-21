class WikiPolicy < ApplicationPolicy
  # alias_method :wiki, :record  # might have order reversed
  attr_reader :wiki, :user

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    @wiki.private == nil || @wiki.private && (@user.role == 'premium' || @user.admin?)
  end

  def edit?
    create?
  end

  def destroy?
    true
  end
end
