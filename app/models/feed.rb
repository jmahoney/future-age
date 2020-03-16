class Feed < ApplicationRecord
  has_many :items

  enum status: {active: 0, flaky: 1, inactive: 2}

  def fetch
    response = HTTParty.get(self.url, format: :plain)
    if response.code == 200
      source_feed = Feedjira.parse(response.body)
      update_feed_details(source_feed, response)
    else
      handle_failed_fetch
    end
  end

  private

  def handle_failed_fetch
    case self.status
    when "active"
      self.status = "flaky"
    when "flaky"
      if self.last_successful_check < 7.days.ago
        self.status = "inactive"
      end
    end

    self.save
  end

  def update_feed_details(source_feed, response)
    if self.name != source_feed.title
      self.name = source_feed.title
    end

    if (response.request.redirect && response.request.uri != self.url)
      self.url = response.request.uri
    end

    if response.code == 200
      case self.status
      when "flaky"
        self.status = "active"
      when "inactive"
        self.status = "flaky"
      end
    end

    if self.changed?
      self.save
    end
  end

end
