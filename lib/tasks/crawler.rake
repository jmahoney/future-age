namespace :crawler do
  task :fetch_feeds => :environment do
    Feed.all.each do |f|
      url = f.url
      response = HTTParty.get url
      if response.code == 200
        parsed_feed = Feedjira.parse response.body
        parsed_feed.entries.each do |e|
          puts e.title
        end
      end
    end
  end
end
