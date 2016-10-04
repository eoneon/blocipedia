class CollaboratorPolicy
  attr_reader :user, :wiki, :collaborator

  def initialize(user, collaborator, wiki)
    @user = user
    @wiki = wiki
    @collaborator = collaborator
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    @user == current_user && @wiki.private && @user.role == 'premium'
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end
end
