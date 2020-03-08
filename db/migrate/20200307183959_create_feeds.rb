class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :name
      t.string :website_url
      t.datetime :last_checked
      t.integer :status, :default => 0
      t.timestamps
    end
  end
end
