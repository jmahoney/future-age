namespace :crawler do
  task :fetch => :environment do
    count = 0
    Feed.where(status: [:active, :flaky]).order(last_checked: :asc).limit(6).each do |feed|
      feed.import
    end
  end
end