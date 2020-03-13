class CreateFetches < ActiveRecord::Migration[6.0]
  def change
    create_table :fetches do |t|
      t.integer :feed_id
      t.datetime :start
      t.datetime :finish
      t.boolean :successful
      t.text :message

      t.timestamps
    end
  end
end
