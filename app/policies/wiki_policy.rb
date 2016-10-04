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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == nil || wiki.user == user || wiki.collaborators.where(user_id: user.id)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == nil || wiki.collaborators.where(user_id: user.id)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
