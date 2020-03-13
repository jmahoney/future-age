class Feed < ApplicationRecord
  has_many :items
  
  enum status: {active: 0, flaky: 2, inactive: 3}

  def fetch
    response = HTTParty.get(self.url, format: :plain)
    if response.code == 200
      parsed_feed = Feedjira.parse(response.body)
      update_feed_details(parsed_feed.title, response.request)
    end
  end

  private 
  def update_feed_details(name, request)
    if self.name != name
      self.name = name
    end

    if (request.redirect && request.uri != self.url)
      self.url = request.uri
    end

    if self.changed?
      self.save
    end
  end

end
