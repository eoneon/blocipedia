class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    # raise Pundit::NotAuthorizedError unless WikiPolicy.new(current_user, @wiki).destroy?
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
