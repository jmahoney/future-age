require 'test_helper'
require 'mocha/minitest'

class FeedTest < ActiveSupport::TestCase
  def setup
    @feed = Feed.first
  end

  test "name is updated if the source feed name has changed" do
    response = stub(code: 200, body: file_fixture('cheerschopper_rss.xml').read)
    HTTParty.expects(:get).with(@feed.url, format: :plain).returns(response)
    @feed.fetch
    assert_equal "cheers, chopper", @feed.name
  end

end
