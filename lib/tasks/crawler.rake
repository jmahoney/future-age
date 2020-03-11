namespace :crawler do
  task :fetch_feeds => :environment do
    Feed.where(status: :active).each do |feed|
      url = feed.url
      
      response = HTTParty.get(url, format: :plain)
      
      if response.code == 200
        parsed_feed = Feedjira.parse(response.body)
        
        parsed_feed.entries.each do |e|
          unique_identifier = e
          item = feed.items.find_by(unique_identifier: e.entry_id) || Item.new

          item.feed_id = feed.id
          item.unique_identifier = e.entry_id
          item.title = e.title
          item.content_html = e.content
          item.url = e.url
          item.external_url = e.external_url if e.respond_to?(:external_url)
          item.save!
        end
      end
    end
  end
end
