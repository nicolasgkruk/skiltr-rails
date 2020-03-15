require 'test_helper'

class SourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sources_new_url
    assert_response :success
  end

end
