class AddLastSuccessfulCrawlToFeeds < ActiveRecord::Migration[6.0]
  def up
    add_column :feeds, :last_successful_crawl, :datetime
  end

  def down
    remove_column :feeds, :last_successful_crawl
  end
end
