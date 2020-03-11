class CreateItems < ActiveRecord::Migration[6.0]
  def up
    create_table :items do |t|
      t.integer :feed_id
      t.string :unique_identifier, null: false
      t.string :title
      t.text :content_html
      t.string :url
      t.string :external_url
      t.text :summary
      t.datetime :date_published
      t.boolean :starred
      t.boolean :read
      t.timestamps
    end
  end
end
