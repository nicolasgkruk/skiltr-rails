module SourcesHelper
  def user_has_sources
    current_user.sources.any?
  end
end
