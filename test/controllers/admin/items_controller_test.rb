require 'test_helper'

class Admin::ItemsControllerTest < ActionDispatch::IntegrationTest

  def login
    post login_url, params: {password: ENV["FUTURE_AGE_USER_PASSWORD"]}
  end

  setup do
    login
    @item = items(:one)
  end

  test "should get index" do
    get admin_items_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post admin_items_url, params: { item: { content_html: @item.content_html, date_published: @item.date_published, external_url: @item.external_url, feed_id: @item.feed_id, summary: @item.summary, title: @item.title, unique_identifier: 'fasdkfhjasdkfjklsd', url: @item.url } }
    end

    assert_redirected_to admin_item_url(Item.last)
  end

  test "should show item" do
    get admin_item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch admin_item_url(@item), params: { item: { content_html: @item.content_html, date_published: @item.date_published, external_url: @item.external_url, feed_id: @item.feed_id, summary: @item.summary, title: @item.title, url: @item.url } }
    assert_redirected_to admin_item_url(@item)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete admin_item_url(@item)
    end

    assert_redirected_to admin_items_url
  end
end
