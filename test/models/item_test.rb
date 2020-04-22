require 'test_helper'

class ImportItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.first
    @source_item = Feedjira::Parser::RSSEntry.new(title: "new title",
      content: "new_content", entry_id:@item.unique_identifier)
    @unchanged_source_item = Feedjira::Parser::RSSEntry.new(title: @item.title,
      content: @item.content_html, entry_id: @item.unique_identifier)
  end

  test "the source item has changed if the title is different" do
     assert @item.source_item_has_changed?(@item, @source_item)
  end

  test "the source item has changed if the content is different" do
    assert @item.source_item_has_changed?(@item, @source_item)
 end

  test "the source item has not changed if the title and content are the same" do
    refute @item.source_item_has_changed?(@item, @unchanged_source_item)
  end

end

class StarringItemTest < ActiveSupport::TestCase
  test "toggle_starred marks an unstarred item as starred" do
    item = items(:unstarred)
    refute item.starred
    item.toggle_starred
    assert item.starred
  end

  test "toggle_starred marks an starred item as unstarred" do
    item = items(:starred)
    assert item.starred
    item.toggle_starred
    refute item.starred
  end
end

class SanitisingItemTest < ActiveSupport::TestCase
  test "content from feeds marked to be sanitised should be basically plain text" do
    item = items(:whitewash)
    assert_equal "testing", item.content
  end

  test "img tags only have an src and alt and width and height attributes" do
    item = items(:imgscrubber)
    expected =  "<img src=\"https://test.com/image.jpg\" alt=\"this is the alt text\" width=\"20\" height=\"20\"> The image had width and height attributes"
    assert_equal expected, item.content
  end

  test "div tags have no attributes" do
    item = items(:divscrubber)
    expected = "<div>test</div>"
    assert_equal expected, item.content
  end
end

class ResolvingRelativeUrlsTest < ActiveSupport::TestCase
  test "relative urls on image tags are resolved to the root when website url doesnt specify a path" do
    item = items(:relativeimagewebsitenopath)
    expected = "<img src=\"https://1.test.com/relative1.jpg\"><img src=\"https://1.test.com/relative2.jpg\">"
    assert_equal expected, item.content
  end

  test "absolute urls are left alone" do
    item = items(:absoluteimage)
    expected = "<img src=\"https://1.test.com/relative1.jpg\"><img src=\"https://1.test.com/relative2.jpg\">"
    assert_equal expected, item.content
  end

  test "relative urls starting with a slash resolve to root when website url specifies a path" do
    item = items(:relativeimagepointingtorootwebsitehaspath)
    expected = "<img src=\"https://cheerschopper.test.com/relative.jpg\">"
    assert_equal expected, item.content
  end

  test "relative urls without a starting slash resolve to website path when website url specifies a path" do
    item = items(:relativeimagepointingpointingtocurrentdirwebsitehaspath)
    expected = "<img src=\"https://cheerschopper.test.com/blog/relative.jpg\">"
    assert_equal expected, item.content
  end
end
