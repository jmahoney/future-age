require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.first
  end

  test "the source item has changed if the title is different" do
     assert @item.source_item_has_changed?("new title", @item.content_html) 
  end

  test "the source item has changed if the content is different" do
    assert @item.source_item_has_changed?(@item.title, "new content") 
 end

  test "the source item has not changed if the title and content are the same" do
    refute @item.source_item_has_changed?(@item.title, @item.content_html)
  end
end
