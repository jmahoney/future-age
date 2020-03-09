namespace :crawler do
  task :fetch_feeds => :environment do
    Feed.all.each do |f|
      puts f.name
    end
  end
end
