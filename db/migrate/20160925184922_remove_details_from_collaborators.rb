class RemoveDetailsFromCollaborators < ActiveRecord::Migration
  def change
    remove_column :collaborators, :references, :users
    remove_column :collaborators, :references, :wikis
  end
end
