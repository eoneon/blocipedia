class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.user_id = params[:collaborator][:user_id]
    @collaborator.wiki = @wiki

    if CollaboratorPolicy.new(current_user, @wiki, @collaborator)
      if @collaborator.save
        flash[:notice] = "Added a collaborator to this wiki."
      else
        flash[:alert] = "Adding collaborator failed."
      end
    end
    redirect_to :back
  end

  def destroy
    collaborator = Collaborator.find(params[:id])

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "Removing collaborator failed."
    end
      redirect_to :back
  end
end
