class AddLastSuccessfulCrawlToFeeds < ActiveRecord::Migration[6.0]
  def up
    add_column :feeds, :last_successful_check, :datetime
  end

  def down
    remove_column :feeds, :last_successful_check
  end
end
