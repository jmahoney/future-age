namespace :crawler do
  task :fetch => :environment do
    count = 0
    Feed.where(status: :active).each do |feed|
      url = feed.url
      response = HTTParty.get(url, format: :plain)

      if response.code == 200
        parsed_feed = Feedjira.parse(response.body)
        parsed_feed.entries.each do |e|
          item = feed.items.find_or_initialize_by(unique_identifier: e.entry_id)
          if item.new_record? || item.source_item_changed?(e.title, e.content_html)
            item.feed_id = feed.id
            item.unique_identifier = e.entry_id
            item.title = e.title
            item.content_html = e.content
            item.url = e.url
            item.external_url = e.external_url if e.respond_to?(:external_url)
            item.date_published = e.published
            item.save
            count += 1
          end
        end
      end
      feed.last_crawled = DateTime.now
    end
    puts "Saved #{count} items"
  end
end
