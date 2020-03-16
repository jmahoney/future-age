class AddLastFailedCrawlToFeeds < ActiveRecord::Migration[6.0]
  def up
    add_column :feeds, :last_failed_check, :datetime
  end

  def down
    remove_column :feeds, :last_failed_check
  end
end
