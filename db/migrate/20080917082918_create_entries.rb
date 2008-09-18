class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :blog_id
      t.datetime :published_at
      t.string :title
      t.text :content
    end
  end

  def self.down
    drop_table :entries
  end
end
