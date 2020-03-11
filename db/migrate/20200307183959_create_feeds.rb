class CreateFeeds < ActiveRecord::Migration[6.0]
  def up
    create_table :feeds do |t|
      t.string :url, null: false
      t.string :name
      t.string :website_url
      t.datetime :last_checked
      t.integer :status, default: 0
      t.timestamps
      t.index :status
    end
  end
end
