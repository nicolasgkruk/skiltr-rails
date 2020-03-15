class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    @projects = current_user.projects.paginate(page: params[:page])
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    @projectSigns = Sign.where(project_id: params[:id]).paginate(page: params[:page])
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

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted"
    redirect_to projects_path
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "Project updated"
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  private

  def project_params
      params.require(:project).permit(:title, :description)
  end

  # Confirms the correct user.
  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil?
  end
end
