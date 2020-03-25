class Feed < ApplicationRecord
  include HTTParty
  default_timeout 30

  has_many :items

  enum status: {active: 0, flaky: 1, inactive: 2}

  def import
    begin
      self.last_checked = Time.now.utc
      response = HTTParty.get(self.url, format: :plain)
      if response.code == 200
        source_feed = Feedjira.parse(response.body)
        update_details(source_feed, response)
        import_items(source_feed.entries)
      else
        handle_failed_fetch
      end
    rescue Exception => e
      logger.info("Exception fetching or parsing feed #{self.id}. #{e.message}")
      handle_failed_fetch
    end
  end

  private

  def handle_failed_fetch
    self.last_failed_check = Time.now.utc
    msg = "Feed #{self.id} couldn't be fetched. "

    case self.status
    when "active"
      msg << "Marking it as flaky."
      self.status = "flaky"
    when "flaky"
      if self.last_successful_check < 7.days.ago.utc
        "It's been a week of failures. Marking it as inactive."
        self.status = "inactive"
      end
    end
    self.save
  end

  def update_details(source_feed, response)
    if self.name != source_feed.title
      self.name = source_feed.title
    end

    if (response.request.redirect && response.request.uri != self.url)
      self.url = response.request.uri
    end

    case self.status
    when "flaky"
      logger.info("Flaky feed #{self.id} fetched ok. Marking it as active")
      self.status = "active"
    when "inactive"
      logger.info("Inactive feed #{self.id} fetched ok. Marking it as active")
      self.status = "flaky"
    end

    self.last_successful_check = Time.now.utc

    self.save
  end

  def import_items(source_items)
    source_items.each do |source_item|
      item = self.items.find_or_initialize_by(unique_identifier: source_item.entry_id)

      if item.new_record? || item.source_item_has_changed?(item, source_item)
        begin
          item.feed_id = self.id
          item.unique_identifier = source_item.entry_id
          item.title = source_item.title
          item.content_html = source_item.content
          item.url = source_item.url
          item.external_url = source_item.external_url if source_item.respond_to?(:external_url)
          item.date_published = source_item.published
          item.save
        rescue Exception => e
          logger.info("Couldn't import source item into feed #{self.id}. #{e.message}")
        end

      end
    end
  end

end
