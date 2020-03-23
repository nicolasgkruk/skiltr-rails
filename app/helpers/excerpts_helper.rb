module ExcerptsHelper
  def user_has_excerpts
    current_user.excerpts.any?
  end
end
