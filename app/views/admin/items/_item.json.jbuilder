json.extract! item, :id, :feed_id, :title, :content_html, :url, :external_url, :summary, :date_published, :created_at, :updated_at
json.url admin_item_url(item, format: :json)
