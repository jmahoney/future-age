json.extract! feed, :id, :url, :name, :website_url, :last_checked, :status, :created_at, :updated_at
json.url admin_feed_url(feed, format: :json)
