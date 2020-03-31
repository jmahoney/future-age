class Item < ApplicationRecord
  belongs_to :feed
  validates_presence_of :unique_identifier
  validates_uniqueness_of :unique_identifier, scope: :feed_id

  def source_item_has_changed?(item, source_item) #assuming the source item looks like feedjira item
    return self.title != source_item.title || self.content_html != source_item.content
  end

  def toggle_starred
    self.starred = !self.starred
    self.save
  end
end
