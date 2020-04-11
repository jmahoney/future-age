require 'test_helper'

class Admin::FeedsControllerTest < ActionDispatch::IntegrationTest
  def login
    post login_url, params: {password: ENV["FUTURE_AGE_USER_PASSWORD"]}
  end

  setup do
    login
    @feed = feeds(:one)
  end

  test "should get index" do
    get admin_feeds_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_feed_url
    assert_response :success
  end

  test "should create feed" do
    assert_difference('Feed.count') do
      post admin_feeds_url, params: { feed: { last_checked: @feed.last_checked, name: @feed.name, status: @feed.status, url: @feed.url, website_url: @feed.website_url } }
    end

    assert_redirected_to admin_feed_url(Feed.last)
  end

  test "should show feed" do
    get admin_feed_url(@feed)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_feed_url(@feed)
    assert_response :success
  end

  test "should update feed" do
    patch admin_feed_url(@feed), params: { feed: { last_checked: @feed.last_checked, name: @feed.name, status: @feed.status, url: @feed.url, website_url: @feed.website_url } }
    assert_redirected_to admin_feed_url(@feed)
  end

  test "should destroy feed" do
    assert_difference('Feed.count', -1) do
      delete admin_feed_url(@feed)
    end

    assert_redirected_to admin_feeds_url
  end
end
