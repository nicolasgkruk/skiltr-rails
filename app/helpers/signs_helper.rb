module SignsHelper
  def user_has_signs
    current_user.signs.any?
  end
end
