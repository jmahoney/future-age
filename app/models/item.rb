class Item < ApplicationRecord
  include Sanitiser

  belongs_to :feed
  validates_presence_of :unique_identifier
  validates_uniqueness_of :unique_identifier, scope: :feed_id

  def source_item_has_changed?(item, source_item) #assuming the source item looks like feedjira item
    return self.title != source_item.title || self.content_html != source_item.content
  end

  def content
    html = self.content_html.present? ? self.content_html : self.summary
    sanitisation_strategy = self.feed.sanitise ? :strict : :basic
    return sanitise(html, sanitisation_strategy)
  end

  def toggle_starred
    self.starred = !self.starred
    self.save
  end
end
