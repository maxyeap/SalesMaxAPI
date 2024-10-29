require "test_helper"

class DealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get deals_url, as: :json
    assert_response :success
  end

  test "should create deal" do
    assert_difference("Deal.count") do
      post deals_url, params: { deal: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show deal" do
    get deal_url(@deal), as: :json
    assert_response :success
  end

  test "should update deal" do
    patch deal_url(@deal), params: { deal: {  } }, as: :json
    assert_response :success
  end

  test "should destroy deal" do
    assert_difference("Deal.count", -1) do
      delete deal_url(@deal), as: :json
    end

    assert_response :no_content
  end
end
