class SourcesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    @sources = current_user.sources.paginate(page: params[:page])
  end

  def new
    @source = Source.new
  end

  def show
    @source = Source.find(params[:id])
    @sourceExcerpts = Excerpt.where(source_id: params[:id]).paginate(page: params[:page])
  end

  def destroy
    Source.find(params[:id]).destroy
    flash[:success] = "Source deleted"
    redirect_to sources_path
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    if @source.update(source_params)
      flash[:success] = "Source updated"
      redirect_to sources_path
    else
      render 'edit'
    end
  end

  def create
    @source = current_user.sources.build(source_params)
    if @source.save
      # flash[:success] = "Source created!"
      # redirect_to sources_path
      render json: @source
    else
      # render 'static_pages/home'
      render json: {errors: @source.errors.full_messages}
    end
  end

  private

  def source_params
    params.require(:source).permit(:title, :author, :url)
  end

  # Confirms the correct user.
  def correct_user
    @source = current_user.sources.find_by(id: params[:id])
    redirect_to root_url if @source.nil?
  end
end
