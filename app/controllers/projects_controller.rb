class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def index
    @projects = Project.paginate(page: params[:page])
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to projects_path
    else
      render 'static_pages/home'
    end
  end

  private

  def project_params
      params.require(:project).permit(:title, :description)
  end
end
