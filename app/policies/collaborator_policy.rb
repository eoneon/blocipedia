class CollaboratorPolicy
  attr_reader :user, :collaborator

  def initialize(user, collaborator)
    @user = user
    @collaborator = collaborator
  end

  def create?
    @collaborator.wiki.user == @user && @collaborator.wiki.private && @user.role == 'premium' 
  end

  def destroy?
    create?
  end
end
