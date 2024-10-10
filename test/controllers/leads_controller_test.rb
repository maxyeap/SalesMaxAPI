require "test_helper"

class LeadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lead = leads(:one)
  end

  test "should get index" do
    get leads_url, as: :json
    assert_response :success
  end

  test "should create lead" do
    assert_difference("Lead.count") do
      post leads_url, params: { lead: { city: @lead.city, country: @lead.country, email: @lead.email, first_name: @lead.first_name, last_name: @lead.last_name, phone: @lead.phone, time_zone: @lead.time_zone } }, as: :json
    end

    assert_response :created
  end

  test "should show lead" do
    get lead_url(@lead), as: :json
    assert_response :success
  end

  test "should update lead" do
    patch lead_url(@lead), params: { lead: { city: @lead.city, country: @lead.country, email: @lead.email, first_name: @lead.first_name, last_name: @lead.last_name, phone: @lead.phone, time_zone: @lead.time_zone } }, as: :json
    assert_response :success
  end

  test "should destroy lead" do
    assert_difference("Lead.count", -1) do
      delete lead_url(@lead), as: :json
    end

    assert_response :no_content
  end
end
