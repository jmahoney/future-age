class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :name
      t.string :website_url
      t.datetime :last_checked
      t.string :status

      t.timestamps
    end
  end
end
