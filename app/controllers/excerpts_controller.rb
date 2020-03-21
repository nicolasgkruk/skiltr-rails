class ExcerptsController < ApplicationController
  before_action :logged_in_user, only: [:create, :index]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    if params.has_key?(:source_id)
      @search_result_excerpts = current_user.excerpts
      @search_result_excerpts = @search_result_excerpts.where(source_id: params[:source_id].to_i) if params[:source_id].present?

      if params[:tag_ids_any].count() > 1
        searchtagIds = params[:tag_ids_any].drop(1).map(&:to_i)
        list_of_excerpt_ids_with_the_tag = current_user.excerpt_tags.where(tag_id: searchtagIds).to_a.map{|x| x[:excerpt_id]}
        @search_result_excerpts = @search_result_excerpts.where(id: list_of_excerpt_ids_with_the_tag)
      end

      @search_result_excerpts = @search_result_excerpts.search_by_content(params[:text_content]) if params[:text_content].present?
      @search_result_excerpts = @search_result_excerpts.paginate(page: params[:page])

      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @excerpts = current_user.excerpts.paginate(page: params[:page])
    end
  end

  def new
    @excerpt = Excerpt.new
  end

  def destroy
    Excerpt.find(params[:id]).destroy
    flash[:success] = "Excerpt deleted"
    redirect_to excerpts_path
  end

  def edit
    @excerpt = Excerpt.find(params[:id])
  end

  def update
    @excerpt = Excerpt.find(params[:id])
    if @excerpt.update(excerpt_params)
      previousTagIds = ExcerptTag.where("excerpt_id = ?", @excerpt.id).to_a.map{|x| x[:tag_id]}
      currentTagIds = params[:excerpt][:tag_ids].drop(1).map(&:to_i)

      for tag in currentTagIds do
        if previousTagIds.exclude?(tag.to_i)
          @excerpt.excerpt_tags.create(user_id: current_user.id, excerpt_id: @excerpt.id, tag_id: tag.to_i)
        end
      end

      for tag in previousTagIds
        if currentTagIds.exclude?(tag.to_i)
          ExcerptTag.destroy_by(excerpt_id: @excerpt.id, tag_id: tag.to_i)
        end
      end

      flash[:success] = "Excerpt updated!"
      redirect_to excerpts_path
    end
  end

  def create
    @excerpt = current_user.excerpts.build(excerpt_params)
    if @excerpt.save
      # Add the excerpt tags
      if params[:excerpt][:tag_ids]
        for tag in params[:excerpt][:tag_ids] do
          @excerpt.excerpt_tags.create(user_id: current_user.id, excerpt_id: @excerpt.id, tag_id: tag)
        end
      end
      flash[:success] = "Excerpt created!"
      redirect_to excerpts_path
    else
      render 'static_pages/home'
    end
  end

  def show
    @excerpt = Excerpt.find(params[:id])
    @signExcerpts = Sign.where(source_id: params[:id]).paginate(page: params[:page])
  end

  private

  def excerpt_params
    params.require(:excerpt).permit(:source_id, :content, :location_reference, :tag_ids, :text_content, :tag_ids_any)
  end

  # Confirms the correct user.
  def correct_user
    @excerpt = current_user.excerpts.find_by(id: params[:id])
    redirect_to root_url if @excerpt.nil?
  end

end
