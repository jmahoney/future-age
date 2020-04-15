class AddSanitiseFlagToFeeds < ActiveRecord::Migration[6.0]
  def up
    add_column :feeds, :sanitise, :boolean, default: false
  end

  def down
    remove_column :feeds, :sanitise
  end
end
