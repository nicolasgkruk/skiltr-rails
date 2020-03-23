module TagsHelper
  def user_has_tags
    current_user.tags.any?
  end
end
