class Item < ApplicationRecord
  belongs_to :feed
  validates_presence_of :unique_identifier
  validates_uniqueness_of :unique_identifier, scope: :feed_id

  def source_item_has_changed?(title, content_html)
    return self.title != title || self.content_html != content_html
  end
end
