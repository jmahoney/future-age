class AddSanitisationStrategyToFeeds < ActiveRecord::Migration[6.0]
  def up
    add_column :feeds, :sanitisation_strategy, :integer, default: 0
  end

  def down
    remove_cilumn :feeds, :sanitisation_strategy
  end
end
