require 'test_helper'

class ItemTest < ActiveSupport::TestCase
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
