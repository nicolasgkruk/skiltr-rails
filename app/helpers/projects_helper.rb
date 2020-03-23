module ProjectsHelper
  def user_has_projects
    current_user.projects.any?
  end
end
