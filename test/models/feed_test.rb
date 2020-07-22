require 'test_helper'
require 'mocha/minitest'

class FeedTest < ActiveSupport::TestCase
  def setup
    @new_feed_url = 'https://test.com/feed.xml'

    @success_response = stub(code: 200,
          body: file_fixture('cheerschopper_rss.xml').read,
          request: stub(redirect: true, uri: @new_feed_url))

    @not_found_response = stub(code: 404,body: "Not found")
  end

  test "name is updated if the source feed name has changed" do
    feed = feeds(:one)
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@success_response)
    feed.import
    assert_equal "cheers, chopper", feed.name
  end

  test "feed url is changed if source feed url has changed" do
    feed = feeds(:two)
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@success_response)
    feed.import
    assert_equal @new_feed_url, feed.url
  end

  test "a flaky feed is marked active if it has been crawled successfully" do
    feed = feeds(:flaky)
    assert_equal "flaky", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@success_response)
    feed.import
    assert_equal "active", feed.status
  end

  test "an inactive feed is marked flaky if it has been crawled successfully" do
    feed = feeds(:inactive)
    assert_equal "inactive", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@success_response)
    feed.import
    assert_equal "flaky", feed.status
  end

  test "an active feed is marked as flaky if the feed cannot be fetched" do
    feed = feeds(:active)
    assert_equal "active", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@not_found_response)
    feed.import
    assert_equal "flaky", feed.status
  end

  test "a flaky feed is marked as inactive if it hasn't been succesfully fetched for a week" do
    feed = feeds(:flaky_for_a_week)
    feed.last_successful_check = 8.days.ago
    feed.save
    assert_equal "flaky", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@not_found_response)
    feed.import
    assert_equal "inactive", feed.status
  end

  test "an active feed that times out is marked as flaky" do
    feed = feeds(:timeout)
    assert_equal "active", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).raises(TimeoutError)
    feed.import
    assert_equal "flaky", feed.status
  end

  test "a feed that has never been crawled can be marked as flaky" do
    feed = feeds(:neverchecked)
    assert_equal "active", feed.status
    HTTParty.expects(:get).with(feed.url, format: :plain, headers: {"User-Agent" => "Httparty"}).returns(@not_found_response)
    feed.import
    assert_equal "flaky", feed.status
  end

  test "maybe_url returns website_url when website_url is populated" do
    feed = feeds(:websiteurlwithpath)
    assert_equal "https://cheerschopper.test.com/blog", feed.maybe_url
  end

  test "maybe_url returns blank when website_url is blank and url is a feedburner url" do
    feed = feeds(:feedburnerurl)
    assert_equal "", feed.maybe_url
  end

  test "maybe_url returns a url with the protocol and host of the url when website_url is blank" do
    feed = feeds(:nowebsiteurl)
    assert_equal "https://cheerschopper.test.com", feed.maybe_url
  end

end
