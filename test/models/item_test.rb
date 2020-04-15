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
end