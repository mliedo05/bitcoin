require "test_helper"

class BitcoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get bitcoins_create_url
    assert_response :success
  end

  test "should get index" do
    get bitcoins_index_url
    assert_response :success
  end

  test "should get destroy" do
    get bitcoins_destroy_url
    assert_response :success
  end
end
