class Feed < ApplicationRecord
  has_many :items
  
  enum status: {active: 0, flaky: 1, inactive: 2}

  def fetch
    response = HTTParty.get(self.url, format: :plain)
    if response.code == 200
      source_feed = Feedjira.parse(response.body)
      update_feed_details(source_feed, response)
    end
  end

  private 
  def update_feed_details(source_feed, response)
    if self.name != source_feed.title
      self.name = source_feed.title
    end

    if (response.request.redirect && response.request.uri != self.url)
      self.url = response.request.uri
    end

    if self.status == 'flaky' && response.code == 200
      self.status = 'active'
    end

    if self.changed?
      self.save
    end
  end

end
