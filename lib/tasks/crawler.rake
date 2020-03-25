namespace :crawler do
  task :fetch => :environment do
    count = 0
    Feed.where(status: :active).order(last_checked: :desc).limit(2).each do |feed|
      feed.import
    end
  end
end
