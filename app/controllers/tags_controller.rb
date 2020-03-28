class TagsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    @tags = current_user.tags.paginate(page: params[:page])
  end

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
    list_of_excerpt_ids_with_the_tag = ExcerptTag.where(tag_id: params[:id]).to_a.map{|x| x[:excerpt_id]}
    @excerptsWithTag = Excerpt.where(id: list_of_excerpt_ids_with_the_tag).paginate(page: params[:page])
  end

  def destroy
    Tag.find(params[:id]).destroy
    flash[:success] = "Tag deleted"
    redirect_to tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:success] = "Tag updated"
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      render json: @tag
      # flash[:success] = "tag created!"
      # redirect_to tags_path
    else
      # render 'static_pages/home'
      render json: {errors: @tag.errors.full_messages}
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:title, :description)
  end

  # Confirms the correct user.
  def correct_user
    @tag = current_user.tags.find_by(id: params[:id])
    redirect_to root_url if @tag.nil?
  end
end
