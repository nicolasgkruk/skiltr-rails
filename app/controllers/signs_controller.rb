class SignsController < ApplicationController
  before_action :logged_in_user, only: [:create, :index]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    if params.has_key?(:project_id)

      @search_result_signs = current_user.signs
      @search_result_signs = @search_result_signs.where(project_id: params[:project_id].to_i) if params[:project_id].present?

      if params[:tag_ids_any].count() > 1
        seachtagIds = params[:tag_ids_any].drop(1).map(&:to_i)
        list_of_excerpt_ids_with_the_tag = current_user.excerpt_tags.where(tag_id: seachtagIds).to_a.map{|x| x[:excerpt_id]}
        list_of_signs_with_excerpts_with_the_tags = current_user.sign_excerpts.where(excerpt_id: list_of_excerpt_ids_with_the_tag).to_a.map{|x| x[:sign_id]}
        @search_result_signs = @search_result_signs.where(id: list_of_signs_with_excerpts_with_the_tags)
      end

      @search_result_signs = @search_result_signs.search_by_content(params[:text_content]) if params[:text_content].present?
      @search_result_signs = @search_result_signs.paginate(page: params[:page])

      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @signs = current_user.signs.paginate(page: params[:page])
    end
  end

  def new
    @sign = Sign.new
    @excerpts_ids = params[:excerpt_ids]
  end

  def destroy
    Sign.find(params[:id]).destroy
    flash[:success] = "Sign deleted"
    redirect_to signs_path
  end

  def edit
    @sign = Sign.find(params[:id])
  end

  def show
    @excerpt = Excerpt.find(params[:id])
    list_of_sign_ids_with_the_excerpt = SignExcerpt.where(excerpt_id: params[:id]).to_a.map{|x| x[:sign_id]}
    @signsWithExcerpt = Sign.where(id: list_of_sign_ids_with_the_excerpt).paginate(page: params[:page])
  end

  def update
    @sign = Sign.find(params[:id])
    if @sign.update(sign_params)
      previousExcerptIds = SignExcerpt.where("sign_id = ?", @sign.id).to_a.map{|x| x[:excerpt_id]}
      currentExcerptIds = params[:sign][:excerpt_ids].drop(1).map(&:to_i)

        for excerpt in currentExcerptIds do
          if previousExcerptIds.exclude?(excerpt.to_i)
            @sign.sign_excerpts.create(user_id: current_user.id, sign_id: @sign.id, excerpt_id: excerpt.to_i)
          end
        end

        for excerpt in previousExcerptIds
          if currentExcerptIds.exclude?(excerpt.to_i)
            SignExcerpt.destroy_by(sign_id: @sign.id, excerpt_id: excerpt.to_i)
          end
        end

      flash[:success] = "Sign updated!"
      redirect_to signs_path
    end
  end

  def create
    @sign = current_user.signs.build(sign_params)
    if @sign.save
      # Add the excerpts
      if params[:sign][:excerpt_ids]
        for excerpt in params[:sign][:excerpt_ids] do
          @sign.sign_excerpts.create(user_id: current_user.id, sign_id: @sign.id, excerpt_id: excerpt)
        end
      end
      flash[:success] = "Sign created!"
      redirect_to signs_path
    else
      render 'static_pages/home'
    end
  end

  private

  def sign_params
    params.require(:sign).permit(:project_id, :content, :tag_ids_any, :text_content, :excerpt_ids)
  end

  # Confirms the correct user.
  def correct_user
    @sign = current_user.signs.find_by(id: params[:id])
    redirect_to root_url if @sign.nil?
  end

end
