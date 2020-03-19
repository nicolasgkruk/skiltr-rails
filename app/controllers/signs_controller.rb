class SignsController < ApplicationController
  before_action :logged_in_user, only: [:create, :index]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  def index
    if params.has_key?(:project_id)
      @search_result_signs = current_user.signs
      @search_result_signs = @search_result_signs.where(project_id: params[:project_id].to_i) if params[:project_id].present?
      @search_result_signs = @search_result_signs.where(source_id: params[:source_id].to_i) if params[:source_id].present?
      @search_result_signs = @search_result_signs.search_by_content_and_excerpt(params[:text_content]) if params[:text_content].present?
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
  end

  def destroy
    Sign.find(params[:id]).destroy
    flash[:success] = "Sign deleted"
    redirect_to signs_path
  end

  def edit
    @sign = Sign.find(params[:id])
  end

  def search
  end

  def update
    @sign = Sign.find(params[:id])
    if @sign.update(sign_params)
      previousTagIds = SignTag.where("sign_id = ?", @sign.id).to_a.map{|x| x[:tag_id]}
      currentTagIds = params[:sign][:tag_ids].drop(1).map(&:to_i)

        for tag in currentTagIds do
          if previousTagIds.exclude?(tag.to_i)
            @sign.sign_tags.create(user_id: current_user.id, sign_id: @sign.id, tag_id: tag.to_i)
          end
        end

        for tag in previousTagIds
          if currentTagIds.exclude?(tag.to_i)
            SignTag.destroy_by(sign_id: @sign.id, tag_id: tag.to_i)
          end
        end

      flash[:success] = "Sign updated!"
      redirect_to signs_path
    end
  end

  def create
    @sign = current_user.signs.build(sign_params)
    if @sign.save
      # Add the sign tags
      if params[:sign][:tag_ids]
        for tag in params[:sign][:tag_ids] do
          @sign.sign_tags.create(user_id: current_user.id, sign_id: @sign.id, tag_id: tag)
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
    params.require(:sign).permit(:project_id, :source_id, :excerpt, :excerpt_location_reference, :content, :tag_ids, :text_content, :tag_ids_all, :tag_ids_any)
  end

  # Confirms the correct user.
  def correct_user
    @sign = current_user.signs.find_by(id: params[:id])
    redirect_to root_url if @sign.nil?
  end

end
