module CollaboratorHelper
  def new_collaborators(wiki)
    users = []
    all_users = User.all
    wiki_collaborators = wiki.collaborators.pluck(:user_id)
    all_users.each do |user|
        if not wiki_collaborators.find {|collaborator| collaborator == user.id}
            users << user
        end
    end
    return users
  end
end
