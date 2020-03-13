require 'test_helper'
require 'mocha/minitest'

class FeedTest < ActiveSupport::TestCase
  def setup
    @new_feed_url = 'https://test.com/feed.xml'
    @response = stub(code: 200, 
          body: file_fixture('cheerschopper_rss.xml').read,
          request: stub(redirect: true, uri: @new_feed_url))
    
  end

  test "name is updated if the source feed name has changed" do
    feed = Feed.first
    HTTParty.expects(:get).with(feed.url, format: :plain).returns(@response)
    feed.fetch
    assert_equal "cheers, chopper", feed.name
  end

  test "feed url is changed if source feed url has changed" do
    feed = Feed.last
    HTTParty.expects(:get).with(feed.url, format: :plain).returns(@response)
    feed.fetch
    assert_equal @new_feed_url, feed.url
  end

end
