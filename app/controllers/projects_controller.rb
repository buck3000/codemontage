class ProjectsController < ApplicationController

  def index
    @featured_projects = 
      if params[:tags].present?
        Project.featured.tagged_with(params[:tags], :any => true) 
      else 
        Project.featured 
      end.with_technologies_and_causes.with_organization

    @favorite_projects = 
      if current_user.present?
        FavoriteProject.where(:user_id => current_user.id).map {|p| p.project_id }.to_set
      else
      end
  end

  def show
    @project = Project.find(params[:id])
    @related_projects = @project.related_projects.length > 0 ? @project.related_projects : false
  end
end
